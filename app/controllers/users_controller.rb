class UsersController < ApplicationController

  before_filter :set_current_user, only:[:join_new_room, :join_room]

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def index; end

  def new; end

  def create
    if !User.valid_entry?(user_params)
      flash[:notice] = "Invalid entry in one of the text-boxes"
      redirect_to request.referrer
    elsif not User.find_by(username: user_params[:username]).blank?
      flash[:notice] = "Username, \'#{user_params[:username]}\' has already been taken"
      redirect_to request.referrer
    else
      @user = User.create_user!(user_params)
      flash[:notice] = "Account with Username \'#{user_params[:username]}\' has been created"
      redirect_to login_path
    end
  end

  def join_new_room
  end

  def join_room
    room = Room.where(invitation_token: params[:user][:room_id])
    room_id = room[0].id
    @current_user.room_id = room_id
    @current_user.save
    flash[:notice] = 'You have successfully joined the room'
    redirect_to room_path room_id
  end

end

