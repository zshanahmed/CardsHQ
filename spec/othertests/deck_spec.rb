require 'rails_helper'
require_relative '../../app/deck'
require_relative '../../app/card'

RSpec.describe Deck do

  #https://github.com/rails/rails/issues/34790
  #######MONKEY PATCH#########
  if RUBY_VERSION>='2.6.0'
    if Rails.version < '5'
      class ActionController::TestResponse < ActionDispatch::TestResponse
        def recycle!
          # hack to avoid MonitorMixin double-initialize error:
          @mon_mutex_owner_object_id = nil
          @mon_mutex = nil
          initialize
        end
      end
    else
      puts "Monkeypatch for ActionController::TestResponse no longer needed"
    end
  end

  SUITS = ["Hearts", "Spades", "Clubs", "Diamonds"]
  RANKS = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"]

  before do
    @deck = Deck.new SUITS, RANKS
  end

  it 'should respond to suits' do
    expect(@deck).to respond_to(:suits)
  end

  it 'should respond to ranks' do
    expect(@deck).to respond_to(:ranks)
  end

  it 'should respond to deck' do
    expect(@deck).to respond_to(:deck)
  end

  it 'should respond to shuffle' do
    expect(@deck).to respond_to(:shuffle)
  end

  it 'should respond to replace_with' do
    expect(@deck).to respond_to(:replace_with)
  end

  it 'gets a new deck with replace_with' do
    deck_of_cards = []
    deck_of_cards.push(Card.new("Hearts", "8"))
    deck_of_cards.push(Card.new("Hearts", "9"))
    new_deck = @deck.dup
    new_deck.replace_with(deck_of_cards)
    expect(@deck.deck).not_to eq(new_deck.deck)
  end

end