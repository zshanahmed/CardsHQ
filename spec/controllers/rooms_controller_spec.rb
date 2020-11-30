require 'rails_helper'

describe RoomsController do
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

  test_hand = [{card_id: 1, user_id: 1, room_id: 1},
               {card_id: 2, user_id: 1, room_id: 1},
               {card_id: 3, user_id: 1, room_id: 1},
               {card_id: 4, user_id: 1, room_id: 1}]
  test_hand2 = [{card_id: 1, user_id: 1, room_id: 2},
                {card_id: 2, user_id: 1, room_id: 2},
                {card_id: 3, user_id: 1, room_id: 2},
                {card_id: 4, user_id: 1, room_id: 2}]
  test1 = {name: 'testroom123'}
  test2 = {name: ''}
  test_valid = {username: 'helloalphatest', password: 'namesbond', email: 'hello@alpha.com'}
  room_test = {name: 'alphatest123'}
  before(:each) do
    @user_controller = UsersController.new
    test_user = User.create_user!(test_valid)
    request.session[:session_token] = test_user.session_token
    test_room = Room.create!(room_test)
    @current_user = User.find_by_session_token(session[:session_token])
    @current_user.room_id = test_room.id
    @current_user.save
    test_room2 = Room.create!({name: "silly_room"})
    Card.create_deck_for_room(1)
    Card.create_deck_for_room(2)
  end

  it 'Should flash a message when room is successfully created' do
    post :create, room: test1
    expect(flash[:success]).to match("Room #{test1[:name]} was created successfully")
  end

  it 'Should flash a message when no name is provided for room' do
    post :create, room: test2
    expect(flash[:notice]).to match('Room name cannot be empty')
  end

  it 'Should flash a message if room name already taken' do
    post :create, room: test1
    post :create, room: test1
    expect(flash[:notice]).to match('Room name already taken')
  end

  it 'should set hand in show method' do
    @current_user = User.find_by_session_token(session[:session_token])
    post :create, room: {name: "hand"}
    room = Room.where(name: "hand").first
    @current_user.room_id = room.id
    @current_user.update(room_id: room.id)
    Hand.create(:card_id => '1267', :user_id => @current_user.id , :room_id => @current_user.room_id)
    get :show , {:id => '1' }
    @hand = Hand.where(:user_id => @current_user.id, :room_id => @current_user.room_id)
    expect(@hand).not_to be_nil
  end
  it 'should not play_card if no cards are selected' do
    @current_user = User.find_by_session_token(session[:session_token])
    post :create, room: {name: "testroom123"}
    room = Room.where(name: "testroom123").first
    @current_user.room_id = room.id
    @current_user.update(room_id: room.id)
    post :play_card , {}
    expect(flash[:notice]).to eq("No cards selected")
  end
  it 'should play_card if cards are selected' do
    @current_user = User.find_by_session_token(session[:session_token])
    post :create, room: {name: "testroom123"}
    room = Room.where(name: "testroom123").first
    @current_user.room_id = room.id
    @current_user.update(room_id: room.id)
    expect(Card).to receive(:add_in_play).with(["141","1"], @current_user.id, 3)
    expect(Card).to receive(:add_in_play).with(["145","1"], @current_user.id, 3)
    post :play_card , {"played_cards"=>{"141"=>"1", "145"=>"1"}}
    expect(flash[:notice]).to eq("Cards played")
  end


  it 'Should flash a message when room is destroyed' do
    delete :destroy, {name: room_test}
    expect(flash[:notice]).to match(/Room destroyed successfully/)
  end
  it 'Should flash a message when a user updates the score' do
    post :update_new_score, "user"=>{"score"=>10}
    expect(flash[:notice]).to eq("Score updated!")
  end

  it 'Should reset the hands of the players in current room, but not in other rooms' do
    test_hand.each {|a| Hand.create!(a)}
    test_hand2.each {|b| Hand.create!(b)}
    post :reset_room

    expect(Hand.where(room_id: 1).blank?).to be true
    expect(Hand.where(room_id: 2).blank?).to be false
  end

  it 'When reset it should set the status of all the cards in the current room to in deck, but not other rooms' do
    Card.where(room_id: 1).each {|card| card.update!(status: 1)}
    Card.where(room_id: 2).each {|card| card.update!(status: 1)}

    post :reset_room

    Card.where(room_id: 1).each {|card| expect(card.status).to eq("in_draw")}
    Card.where(room_id: 2).each {|card| expect(card.status).to eq("in_sink")}
  end
end
