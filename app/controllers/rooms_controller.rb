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
  end

  def show
    @hand = Hand.where(:user_id => @current_user.id, :room_id => @current_user.room_id)
    flash[:notice] = "#{@current_user.id}'s hand"
  end

  def create
    if params[:room][:name].empty?
      flash[:notice] = 'Room name cannot be empty'
      redirect_to new_room_path
    elsif Room.find_by(name: params[:room][:name])
      flash[:notice] = 'Room name already taken'
      redirect_to new_room_path
    else
      @room = Room.create!(permitted_parameters)
      Card.create_deck_for_room(@room.id)
      @current_user.update(room_id: @room.id)
      flash[:notice] = "Room #{@room.name} was created successfully"
      redirect_to room_path @room
    end
  end

  def play_card
    if(params[:played_cards] == nil)
      flash[:notice] = "No cards selected"
      redirect_to room_path @current_user.room_id
    else
      params[:played_cards].each do |card|
        Card.add_in_play(card,@current_user.id ,3)
      end
      flash[:notice] = "Cards played"
      redirect_to room_path @current_user.room_id
    end
  end

  def destroy
    @current_room = Room.where(id: @current_user.room_id)
    Room.destroy(@current_room)
    flash[:notice] = 'Room destroyed successfully'
    redirect_to rooms_path
  end
end
