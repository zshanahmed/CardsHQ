class TradeController < ApplicationController
  before_action :authenticate_user!
  before_filter :set_current_user

  def index
    @hand = Hand.where(:user_id => @current_user.id, :room_id => @current_user.room_id)
    if @hand.blank?
      flash[:notice] = "No cards to Trade"
      redirect_to room_path @current_user.room_id
    end
  end

  def trade_card
    cards = params["traded"]
    user = params["user"]["tradeuser"]

    if cards.nil? || user == ""
      flash[:notice] = "No cards selected or username not entered"
      redirect_to trade_index_path
    else
      cards = cards.keys
      cards.map! { |a| a.to_i }
      user_id_trade = User.where(username: user, room_id: @current_user.room_id).first
      if user_id_trade.blank?
        flash[:notice] = "Username does not exist"
        redirect_to trade_index_path
      else
        user_id_trade = user_id_trade.id
        hands = Hand.where(room_id: @current_user.room_id)
        hands.each do |card|
          cards.each { |a| if a == card.card_id; card.update!(user_id: user_id_trade) end }
        end
        flash[:notice] = "Cards traded"
        redirect_to room_path @current_user.room_id
      end
    end
  end
end
