require 'spec_helper'
require 'rails_helper'

describe TradeController do
  login_user
  # https://github.com/rails/rails/issues/34790
  # MONKEY PATCH
  if RUBY_VERSION>='2.6.0'
    if Rails.version < '5'
      class ActionController::TestResponse < ActionDispatch::TestResponse
        def recycle!
          # Hack to avoid MonitorMixin double-initialize error:
          @mon_mutex_owner_object_id = nil
          @mon_mutex = nil
          initialize
        end
      end
    else
      puts 'Monkeypatch for ActionController::TestResponse no longer needed'
    end
  end

  test_valid = {username: 'helloalphatest', password: 'namesbond1234', email: 'hello@alpha.com'}
  before(:each) do
    test_room2 = Room.create!({name: "silly_room"})
    @current_user = subject.set_current_user
    @current_user.room_id = test_room2.id
    @current_user.save
    @current_room = Room.where(id: @current_user.room_id)
    Card.create_deck_for_room(test_room2.id)
    test_user2 = User.create!(test_valid)
    test_user2.room_id = test_room2.id
    test_user2.save
  end

  it 'index view should be rendered' do
    get :index
    expect(flash[:notice]).to eq "No cards to Trade"
  end
  it 'should notify users when necessary fields are not selected and they attempt to trade cards' do
    post :trade_card, 'user'=>{'tradeuser'=>''}
    expect(flash[:notice]).to eq "No cards selected or username not entered"
  end
  it 'should notify user when the username entered is not correct or does not exist' do
    post :trade_card, 'traded'=>{'1'=>'1','2'=>'1'}, 'user'=>{'tradeuser'=>'coolguy1234'}
    expect(flash[:notice]).to eq "Username does not exist"
  end
  it 'should trade cards when correct username and cards are selected' do
    Hand.create!(user_id: 1, room_id: 1, card_id: 1)
    Hand.create!(user_id: 1, room_id: 1, card_id: 2)
    post :trade_card, 'traded'=>{'1'=>'1','2'=>'1'}, 'user'=>{'tradeuser'=>'helloalphatest'}
    hands = Hand.all
    hands.each { |a| expect(a.user_id).to eq User.where(username: 'helloalphatest').first.id }
  end
end