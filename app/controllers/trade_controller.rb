class TradeController < ApplicationController
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
      user_id_trade = User.where(username: user).ids
      if user_id_trade.blank?
        flash[:notice] = "Username does not exist"
        redirect_to trade_index_path
      else
        hands = Hand.where(room_id: @current_user.room_id)
        flash[:notice] = "Cards traded"
        redirect_to room_path @current_user.room_id
      end
    end
  end
end