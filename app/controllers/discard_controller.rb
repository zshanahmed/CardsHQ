class DiscardController < ActionController::Base

  def index
    @current_user ||= session[:session_token ] && User.find_by_session_token(session[:session_token])
    @hand = Hand.where(:user_id => @current_user.id, :room_id => @current_user.room_id)
    if @hand.blank?
      flash[:notice] = "No cards to Discard"
    end
  end

  def discard_card

  end
end