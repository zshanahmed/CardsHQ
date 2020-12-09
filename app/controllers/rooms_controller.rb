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

  def new ; end

  def show
    @room.users << User.where(:session_token=> session[:session_token]).first

    @num_cards = []
    @room.users.all.each do |user|
      # when score is ready
      @num_cards.append([user.username, Hand.where(:user_id => user.id, :room_id => user.room_id).length, user.score])
      # @num_cards.append([user.username, Hand.where(:user_id => user.id, :room_id => user.room_id).length])
    end
    @hand = Hand.where(:user_id => @current_user.id, :room_id => @current_user.room_id)
    #flash[:notice] = "#{@current_user.id}'s hand"
    @score = @current_user.score
    @played_cards = Card.where(user_id: @current_user.id, room_id: @current_user.room_id, status: 3)
    @users_in_room = User.where(room_id: @current_user.room_id)
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

      flash[:success] = "Room #{@room.name} was created successfully"
      redirect_to room_path @room
    end
  end

  def destroy
    @current_room = Room.where(id: @current_user.room_id)
    Card.where(room_id: @current_user.room_id).delete_all
    Room.destroy(@current_room)
    flash[:notice] = 'Room destroyed successfully'
    redirect_to rooms_path
  end

  def update_score; end

  def update_new_score
    @current_user.score = params[:user][:score]
    @current_user.save
    redirect_to room_path @current_user.room_id
    flash[:notice] = "Score updated!"
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

  def reset_room
    Hand.where(room_id: @current_user.room_id).delete_all
    Card.where(room_id: @current_user.room_id).each do |a|
      a.update!(status: 0)
      unless a.room_id == '1'
        a.delete
      end
    end
    redirect_to room_path @current_user.room_id
  end

  def add_deck
    number_cards = Card.where(room_id: @current_user.room_id).length
    deck_number = (number_cards / 52) + 1 #deck number to be assigned to new deck
    if deck_number < 5
      Card.create_deck_for_room(@current_user.room_id, deck_number) # creates new deck with calculated deck number
    else
      flash[:notice] = "You are not allowed to have more than 4 decks."
    end
    redirect_to room_path @current_user.room_id
  end
end
