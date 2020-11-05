class SessionsController < ApplicationController
  def new
   end

  # @return [Object]
  def create
    username = params[:username][:username]
    password = params[:password][:password]
    @@tempUser = User.where(username: username).where(password: password).first
    puts @@tempUser
    if(!@@tempUser.nil?)
      flash[:notice] = 'Login Successful'
      puts 'login successful'
      session[:session_token] = @@tempUser.session_token
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
