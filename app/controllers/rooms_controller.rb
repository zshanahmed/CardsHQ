class RoomsController < ApplicationController

  before_action :load_entities, :authenticate_user!
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
    room_number = request.original_url.split('/')
    if @current_user.room_id != room_number[room_number.length-1].to_i
      redirect_to rooms_path
    else
      gon.room_id = @current_user.room_id.to_s
      @num_cards = []
      @room.users.all.each do |user|
        user_id = user.email.split("@")[0]
        @num_cards.append([user_id, Hand.where(user_id: user.id, room_id: user.room_id).length, user.score])
      end
      @hand = Hand.where(user_id: @current_user.id, room_id: @current_user.room_id)
      @score = @current_user.score

      played_cards = Card.where(room_id: @current_user.room_id, status: 3).order('updated_at DESC').first(6)
      @player_info = []
      played_cards.each do |a|
        username = User.where(id: a.user_id).first.username
        @player_info.append([username, a.suit, a.rank]) #0 is username, 1 is suit, 3 is rank
      end

      @num_discarded_cards = Card.where(room_id: @current_user.room_id, status: 1).count
      @num_in_deck = Card.where(room_id: @current_user.room_id, status: 0).count
      @num_deck = Card.where(room_id: @current_user.room_id).count / 52
      @users_in_room = User.where(room_id: @current_user.room_id)
    end
    # @room.users << User.where(session_token: session[:session_token]).first
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
    valid = @current_user.save
    if valid
      flash[:notice] = "Score updated!"
    else
      flash[:notice] = "Score must be less than 10 characters"
    end
    redirect_to room_path @current_user.room_id
  end

  def play_card
    if(params[:played_cards] == nil)
      flash[:notice] = "No cards selected"
      redirect_to room_path @current_user.room_id
    else
      store_arr = []
      params[:played_cards].each do |card|
        Card.add_in_play(card,@current_user.id ,3)
        store_arr.append([Card.where(id: card).first.rank, Card.where(id:card).first.suit])
      end


      Pusher.trigger(@current_user.room_id.to_s, 'new-action', { #@current_user.room_id.to_s
                       username: @current_user.username,
                       action: 'played',
                       info: store_arr
                     })
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
