class DiscardController < ApplicationController

  before_filter :set_current_user
  def index
    @hand = Hand.where(:user_id => @current_user.id, :room_id => @current_user.room_id)
    if @hand.blank?
      flash[:notice] = "No cards to Discard"
      redirect_to room_path @current_user.room_id
    end
  end

  def discard_card
    cards = params["discarded"]
    if !cards.nil?
      # Pusher.trigger('new', 'new-action', {
      #     # info: @player_info[0]
      #     info: @current_user.username + " discarded "+ Card.where(id: cards.first[0]).first.rank + " of " + Card.where(id: cards.first[0]).first.suit # @current_user.username.to_s + " discarded "
      # })
      pusher_string = ""
      cards.each do |card_id,junk| 
        Card.add_in_play(card_id, @current_user.id, 2)
        pusher_string = pusher_string + ", " + Card.where(id: card_id).first.rank + " of " + Card.where(id:card_id).first.suit
      end
      Pusher.trigger('new', 'new-action', {
          info: @current_user.username + " discarded "+  pusher_string
      })
      flash[:notice] = "Cards have been discarded"

      redirect_to room_path @current_user.room_id
    else
      flash[:notice] = "No cards selected"
      redirect_to discard_index_path
    end
  end
end