class LinksController < ApplicationController
  def new
    @link = Link.new
  end

  def create
    @link = Link.find_or_initialize_by(link_params)

    if @link.url == ENV['ADMIN_URL']
      session[:admin] = true
      return redirect_to admin_path
    end

    @minute_count = params[:expire_after].to_i

    if not valid_minute_counts.include?(@minute_count)
      @bad_expire = true
      @link.errors.add(:url)
    end

    if @bad_expire.nil? && @link.save
    # if @bad_expire.nil? && @link.valid?
      # Assign a short word to this link
      url_word = UrlWord.where('expires_at < ?', DateTime.now).order(Arel.sql('RANDOM()')).limit(1).first

      if url_word.nil?
        @all_taken = true
        return render 'new'
      end

      url_word.link = @link
      url_word.expires_at = DateTime.now + @minute_count.minutes
      url_word.save!

      @word = url_word.word
      render 'create'
    else
      puts "UOUEOEUOEUOUEOUE #{@bad_expire} #{@minute_count}"
      puts "NOO #{@link.errors.full_messages.inspect} #{@link.inspect}"
      render 'new'
    end
  end

  def show
    search_term = params[:path] && params[:path].downcase
    word = UrlWord.find_by(:word => search_term)
    puts "Finding #{search_term} -> #{word.inspect}"

    if word.nil? || word.link_id.nil? || word.expired?
      # Free word if needed
      word.update(:link_id => nil) if word && word.expired?
      raise ActionController::RoutingError.new('Not Found')
    else
      redirect_to word.link.url
    end
  end

private

  def valid_minute_counts
    [5, 30, 60, 60*6, 60*12]
  end

  def link_params
    params.require(:link).permit(:url)
  end
end
