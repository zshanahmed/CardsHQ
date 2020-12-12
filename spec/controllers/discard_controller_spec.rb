require 'rails_helper'

describe DiscardController do
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

  after(:all) do
    DatabaseCleaner.clean
  end

  test1 = {name: 'testroom123'}
  test2 = {name: ''}
  test_valid = {username: 'helloalphatest', password: 'namesbond', email: 'hello@alpha.com'}
  room_test = {name: 'alphatest123'}
  before(:each) do
    test_room = Room.create!({name: "silly_room"})
    @current_user = subject.set_current_user
    @current_user.room_id = test_room.id
    @current_user.save
    @current_room = Room.where(id: @current_user.room_id)
    Card.create_deck_for_room(test_room.id)
    Hand.create!({:user_id=>@current_user.id, :card_id=>10})
  end

  it 'index.html.erb view should be rendered' do
    get :index
    expect(flash[:notice]).to eq "No cards to Discard"
  end

  it 'flashes that is has discarded cards when cards discarded' do
    post :discard_card,"discarded"=>{"10"=>"1"}
    expect(flash[:notice]).to eq("Cards have been discarded")
  end

  it 'flashes that nothing is dicarded when no cards are passed' do
    post :discard_card
    expect(flash[:notice]).to eq("No cards selected")
  end
end