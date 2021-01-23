class ApplicationController < ActionController::Base
  include ResultHandlers
  protect_from_forgery with: :null_session
end
