class RoomsController < ApplicationController

  before_action :load_entities


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

  end

  def create
    @room = Room.new permitted_parameters

    if @room.save
      flash[:notice] = "Room #{@room.name} was created successfully"
      redirect_to room_path @room
    else
      render :new
    end
  end

end
