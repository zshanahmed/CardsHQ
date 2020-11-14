require_relative './card'
class Deck
  attr_reader :deck, :suits, :ranks
  SUITS = ["Hearts", "Spades", "Clubs", "Diamonds"]
  RANKS = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"]
  def initialize suits, ranks
    @deck = []
    @discardPile = []
    @suits = suits
    @ranks = ranks
    create_deck
  end

  def shuffle
    @deck.shuffle!
  end

  def draw
    @deck.pop
    ## add to user hand after popping.
  end
  def discard(card)
    @discardPile.add(card)
  end

  def replace_with new_deck
    @suits = []
    @ranks = []
    @deck = new_deck

    new_deck.each do |card|
      add_suits_and_ranks(card)
    end
    self
  end

  private

  def create_deck
    suits.each do |suit|
      ranks.each do |rank|
        @deck.push(Card.new(suit, rank))
      end
    end
  end

  def add_suits_and_ranks card
    suit = card.suit
    rank = card.rank

    @suits.push(suit) unless @suits.include? suit
    @ranks.push(suit) unless @ranks.include? rank

  end

end
