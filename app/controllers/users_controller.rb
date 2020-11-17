class UsersController < ApplicationController

  before_filter :set_current_user, only:[:join_new_room, :join_room , :draw_card]

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def index
    @users = User.all
  end

  def new
  end

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
    byebug
    room_id = room[0].id
    @current_user.room_id = room_id
    @current_user.save
    redirect_to room_path room_id
  end

  def draw_card
    cards = Card.where(room_id: @current_user.room_id, status: 0)
    # shuffle and get first
    card = cards.shuffle.first
    # change status for card
    byebug
    card.update(status: 1)
    # set card id for user
    @current_user.card_id = card.id
    # check for duplicate cards if they exist redirect to a different path
    Hand.create(:card_id => @current_user.card_id, :user_id => @current_user.id , :room_id => @current_user.room_id)

  end
end


