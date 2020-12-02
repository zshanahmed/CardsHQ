class TradeController < ApplicationController
  before_filter :set_current_user
  def index
    @hand = Hand.where(:user_id => @current_user.id, :room_id => @current_user.room_id)
    if @hand.blank?
      flash[:notice] = "No cards to Discard"
      redirect_to room_path @current_user.room_id
    end
  end

  def trade_card
    redirect_to room_path @current_user.room_id
  end

end