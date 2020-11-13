class GameController < ApplicationController
  before_filter :set_current_user

  def decks
    @deck = Deck.all
  end
end
