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

  def index; end

  def new; end

  def show; end

  def create
    if params[:room][:name].empty?
      flash[:notice] = 'Room name cannot be empty'
      redirect_to new_room_path
    elsif Room.find_by(name: params[:room][:name])
      flash[:notice] = 'Room name already taken'
      redirect_to new_room_path
    else
      @room = Room.create!(permitted_parameters)
      flash[:notice] = "Room #{@room.name} was created successfully"
      redirect_to room_path @room
    end
  end

  def current_deck
    @room.deck
  end

  def remove_card
    @room.deck = @room.deck.pop
    @room.save
  end

end
