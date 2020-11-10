class GameController < ApplicationController
  def decks
    @deck = Deck.all
  end
end
