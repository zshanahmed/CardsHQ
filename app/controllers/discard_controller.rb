class DiscardController < ActionController::Base
  before_filter :index
  def index
    @current_user ||= session[:session_token ] && User.find_by_session_token(session[:session_token])
    @hand = Hand.where(:user_id => @current_user.id, :room_id => @current_user.room_id)
    if @hand.blank?
      flash[:notice] = "No cards to Discard"
      redirect_to room_path @current_user.room_id
    end
  end

  def discard_card
    @current_user ||= session[:session_token ] && User.find_by_session_token(session[:session_token])
    cards = params["discarded"]
    cards.each {|card_id,junk| Card.add_in_play(card_id, @current_user.id, 2)}
    flash[:notice] = "Cards have been discarded"
    redirect_to room_path @current_user.room_id
  end
end