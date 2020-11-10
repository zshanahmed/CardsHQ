class SessionsController < ApplicationController
  ###
  # This line was added so that i can test the endpoints for this controller
  # from CORS.
  skip_before_action :verify_authenticity_token
  def new
   end

  ##
  # A method to create a session using username and password.
  # POST Request at /login_create
  # Body: application/json
  # Response:Html
  # {
  #
  # "username":{
  # "username":"type_here"
  #           },
  # "password":{
  # "password":"type_here"
  #           }
  #
  # }
  # return status 200 ok if everything is successful.
  def create
    if(params[:username][:username].nil? ||params[:username][:username].empty?)
      flash[:notice] = 'Invalid username/password'
      redirect_to login_path
    elsif(params[:password][:password].nil? || params[:password][:password].empty?)
      puts 'In here'
      flash[:notice] = 'Invalid password'
      redirect_to login_path
    else
      username = params[:username][:username]
      password = params[:password][:password]
      @@tempUser = User.where(:username => username).where(:password=> password).first
      if(!@@tempUser.nil?)
        flash[:notice] = 'Login Successful'
        session[:session_token] = @@tempUser.session_token
        redirect_to game_decks_path
      else
        flash[:notice] = 'Invalid user-id or password combination.'
        redirect_to login_path
      end
    end
  end

  def destroy
    reset_session
  end
end
