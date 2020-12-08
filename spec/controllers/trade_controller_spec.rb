describe TradeController do
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
    test_user = User.create_user!(test_valid)
    request.session[:session_token] = test_user.session_token
    test_room = Room.create!(room_test)
    Card.create_deck_for_room(test_room.id)
    @current_user = User.find_by_session_token(session[:session_token])
    @current_user.room_id = test_room.id
    @current_user.save
    test_valid2 = test_valid
    test_valid2[:username] = 'coolguy123'
    test_user2 = User.create_user!(test_valid2)
    test_user2.room_id = test_room.id
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
    post :trade_card, 'traded'=>{'1'=>'1','2'=>'1'}, 'user'=>{'tradeuser'=>'coolguy123'}
    hands = Hand.all
    hands.each { |a| expect(a.user_id).to eq User.where(username: 'coolguy123').first.id }
  end
end