class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def new
   end

  # @return [Object]
  def create
    username = params[:username][:username]
    password = params[:password][:password]
    @@tempUser = User.where(username: username).where(password: password).first
    if(!@@tempUser.nil?)
      flash[:notice] = 'Login Successful'
      session[:session_token] = @@tempUser.session_token
      puts 'successful'
      redirect_to login_path
    else
      flash[:notice] = 'Invalid user-id/email combination.'
      puts 'unsuccessful'
      redirect_to login_path
    end
  end

  def destroy
    reset_session
  end
end
