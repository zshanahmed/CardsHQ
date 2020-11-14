require 'rails_helper'
require_relative '../../app/card'

RSpec.describe Card do
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
    suit = "Hearts"
    rank = '8'

    @card = Card.new suit, rank
  end

  it 'should respond to suit' do
    expect(@card).to respond_to(:suit)
  end

  it 'should respond to rank' do
    expect(@card).to respond_to(:rank)
  end

  it 'should respond to show' do
    expect(@card).to respond_to(:show)
  end

  it 'should return hearts for suit' do
    expect(@card.suit).to eq('Hearts')
  end

  it 'should return 8 for rank' do
    expect(@card.rank).to eq('8')
  end

  it 'should return true for show' do
    expect(@card.show).to eq(true)
  end

  # it 'should return the suit and rank if show is true' do
  #   expect("#{@card}").to eq("#{@card.rank} of #{@card.suit}.")
  # end
  #
  # it 'should not return the suit and rank if show is false' do
  #   @card.show = false
  #   expect("#{@card}").to eq("Card is face down right now.")
  # end
end