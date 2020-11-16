require 'rails_helper'
require_relative '../../app/hand'
require_relative '../../app/card'

describe Hand do
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

  before do
    @suits = ["Hearts", "Spades", "Clubs", "Diamonds"]
    @hand = Hand.new([Card.new("Hearts","2"),
                      Card.new("Spades","2"),
                      Card.new("Clubs","2"),
                      Card.new("Diamonds","2")])
  end

  it 'Should be able to return the hand' do
    @hand.show_hand.each_with_index {|card,i| expect(card.suit).to eql(@suits[i]) }
  end
end