class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  skip_before_action :verify_authenticity_token
  protect_from_forgery with: :exception
  def set_current_user
    @current_user ||= warden.authenticate(scope: :user)
  end
  helper_method :set_current_user
end