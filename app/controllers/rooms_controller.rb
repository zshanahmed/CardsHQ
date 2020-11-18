class RoomsController < ApplicationController

  before_action :load_entities
  before_filter :set_current_user

  def load_entities
    @rooms = Room.all
    @room = Room.find(params[:id]) if params[:id]
  end

  def permitted_parameters
    params.require(:room).permit(:name)
  end

  def index
    @rooms = Room.all
  end

  def new
    # @users = User.all
  end

  def show
    @room.users << User.where(:session_token=> session[:session_token]).first
    # byebug
    @hand = Hand.where(:user_id => @current_user.id, :room_id => @current_user.room_id)
  end

  def create
    @room = Room.new permitted_parameters
# <<<<<<< HEAD
# =======
#     byebug
# >>>>>>> 9d9948aa06f0f81ce2ef0a58aa5100a0b81919cf
    if @room.save
      byebug
      Card.create_deck_for_room(@room.id)
      flash[:notice] = "Room #{@room.name} was created successfully"
      redirect_to room_path @room
    else
      render :new
    end
  end

  def show_hand

  end

end
