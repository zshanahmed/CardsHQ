class SessionsController < ApplicationController

  def create_auth
    @user = User.find_or_create_from_auth_hash(auth_hash)
    session_token = SecureRandom.base64(10)
    @user.session_token = session_token
    @user.save
    session[:session_token] = @user.session_token
    redirect_to rooms_path
  end

  def create
    if(params[:username][:username].nil? ||params[:username][:username].empty?)
      flash[:notice] = 'Invalid username/password'
      redirect_to login_path
    elsif(params[:password][:password].nil? || params[:password][:password].empty?)
      flash[:notice] = 'Invalid password'
      redirect_to login_path
    else
      username = params[:username][:username]
      password = params[:password][:password]
      @@tempUser = User.where(:username => username).where(:password=> password).first
      if(!@@tempUser.nil?)
        flash[:success] = 'Login Successful'
        session[:session_token] = @@tempUser.session_token
        redirect_to rooms_path
      else
        flash[:notice] = 'Invalid user-id or password combination.'
        redirect_to login_path
      end
    end
  end

  def destroy
    if set_current_user
      session.delete(:user_id)
      flash[:success] = "You have been logged out!"
    end
    redirect_to root_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end