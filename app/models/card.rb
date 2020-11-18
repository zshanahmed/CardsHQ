class Card < ActiveRecord::Base
 has_many :hands
 has_many :user  , through: :hand

 enum status: [ :in_draw, :in_sink, :in_hand ,:in_play]

 @SUITS = %w[Spades Clubs Hearts Diamond]
 @RANKS= %w[2 3 4 5 6 7 8 9 10 Jack Queen King Ace]

 ##
 # A method that creates a deck for each room
 #
 def self.create_deck_for_room(room_id)
  @SUITS.each do |s|
   @RANKS.each do |r|
    Card.create(suit: s, rank:r, room_id: room_id, status: 0)
   end
  end
 end
end
