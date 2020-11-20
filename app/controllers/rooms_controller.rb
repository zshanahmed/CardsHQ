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

  end

  def show
    byebug
    @hand = Hand.where(:user_id => @current_user.id, :room_id => @current_user.room_id)
    @score = @current_user.score
  end

  def create
    @room = Room.new permitted_parameters
    byebug
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
  def update_score

  end
  def update_new_score
    byebug
    @current_user.score = params[:user][:score]
    @current_user.save
  end

end
