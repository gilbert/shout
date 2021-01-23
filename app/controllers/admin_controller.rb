class AdminController < ApplicationController
  before_action :redirect_unless_admin

  def new
    @link = Link.new
    @admin_words = UrlWord.where('expires_at > ?', DateTime.now + 24.hours).includes(:link).order('updated_at DESC')
  end

  def create
    @link = Link.new(link_params)
    @word = params[:word].downcase.gsub(/ +/, '-').gsub(/[^a-z0-9\-]/, '')

    @url_word = UrlWord.find_by(word: @word)
    if @url_word.nil?
      @url_word = UrlWord.create!(admin_only: true, word: @word)
    end

    @word_is_free = @url_word.link_id.nil?

    if @word.blank?
      @error = 'Please enter a word'
    elsif !@word_is_free
      @error = 'Word is taken'
    elsif !@link.save
      @error = @link.errors.full_messages.first
    else
      # Word is free to use!
      @url_word.link = @link
      @url_word.expires_at = DateTime.now + 10.years
      @url_word.save!

      @minute_count = 60 * 24 * 356 * 10
    end

    if @error
      handle_failure(admin_path, flash: @error)
    else
      handle_success(admin_path, flash: 'Link created successfully.')
    end
  end

  def destroy
    @url_word = UrlWord.find(params[:word])
    @url_word.update(link_id: nil, expires_at: DateTime.now)
    handle_success(admin_path, flash: %Q{Deletede "#{@url_word.word}"})
  end

  def sign_out
    session.clear
    redirect_to root_path
  end

  private

  def link_params
    params.require(:link).permit(:url)
  end

  def redirect_unless_admin
    raise ActionController::RoutingError.new('Not Found') unless session[:admin]
  end
end
