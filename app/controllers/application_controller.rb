class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #skip_before_action :verify_authenticity_token
  skip_before_filter :verify_authenticity_token, :only => :create
  protect_from_forgery with: :exception
  byebug
  def set_current_user
    @current_user ||= warden.authenticate(scope: :user)
  end
  helper_method :set_current_user
end