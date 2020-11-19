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
    @hand = Hand.where(:user_id => @current_user.id, :room_id => @current_user.room_id)
  end

  def create
    @room = Room.new permitted_parameters
    if @room.save
      Card.create_deck_for_room(@room.id)
      flash[:notice] = "Room #{@room.name} was created successfully"
      redirect_to room_path @room
    else
      render :new
    end
  end

  def play_card
    if(params[:played_cards] == nil)
      flash[:notice] = "No cards selected"
      redirect_to room_path
    else
      params[:played_cards].each do |card|
        Card.add_in_play(card,@current_user.id ,3)
      end
      flash[:notice] = "Cards played"
      redirect_to room_path @current_user.room_id
    end
  end

end
