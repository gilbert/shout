module ResultHandlers
  extend ActiveSupport::Concern

  def handle_success(path, flash: nil, redirect_js: false)
    if request.xhr? && !redirect_js
      self.flash.now[:success] = flash
    else
      self.flash[:success] = flash
    end
    respond_to do |format|
      format.html { redirect_to path }
      format.js {
        if redirect_js
          # https://github.com/turbolinks/turbolinks-rails/blob/56cf71467edce244042271f69cb58680e4c12cdf/lib/turbolinks/redirection.rb#L26
          redirect_to path, turbolinks: 'advance'
        elsif !template_exists?([
          self.class.module_parent == Object ? nil : self.class.module_parent.to_s.downcase,
          controller_name,
          action_name
        ].compact.join('/'))
          render template: 'common/blank'
        end
      }
    end
  end

  def handle_failure(path, flash:, status: 400)
    if request.xhr?
      self.flash.now[:error] = flash
    else
      self.flash[:error] = flash
    end
    respond_to do |format|
      format.html { redirect_to path }
      format.js { render template: 'common/blank', status: 400 }
    end
  end

  def render_failure(view, flash:, status: 400)
    self.flash.now[:error] = flash
    respond_to do |format|
      format.html { yield if block_given?; render view, status: 400 }
      format.js {
        if template_exists?(action_name, controller_name, false)
          render status: status
        else
          render template: 'common/blank', status: status
        end
      }
    end
  end
end
