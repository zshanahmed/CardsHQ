require 'spec_helper'
require 'rails_helper'

describe UsersController do

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
    ########################
  #
  # #https://stackoverflow.com/questions/6040479/rspec-testing-redirect-to-back
  # before(:each) do
  #   request.env["HTTP_REFERER"] = "where_i_came_from"
  # end

  after(:all) do
    DatabaseCleaner.clean
  end

  testing123 = [{username: '', password: '', email: ''},
                {username: 'glunk', password: 'chunk', email: ''},
                {username: 'bump', password: '', email: 'fump'},
                {username: 'b1po8rc3r^^O(*SADAOql2keudaf[;][/]', password: '', email: 'fump'},
                {username: 'fasdfl', password: '        ', email: 'fpoiadsf'},
                {username: '     ', password: 'pas sword', email: '     '}]

  testing345 = [{username: 'meltybuttyboi',password: "haxxorr",email: "holisticpanda"},
                {username: 'meltybuttyboi',password: "haxxorr",email: "holisticpanda"}]

  testing567= [{username: 'I_am_great', password: 'But_dont_mind_me', email: 'chumbleGUmpus'},
               {username: 'hello_123',password: 'big', email: 'boi'}]

  test_valid = {username: 'helloalphatest', password: 'namesbond', email: 'hello@alpha.com'}


  invalid = "Invalid entry in one of the text-boxes"

  it 'Should flash a message "Invalid entry in one of the text-boxes" if username, password, or email is blank' do
    testing123.each do |testData|
      post :create, user: testData
      expect(flash[:notice]).to match(invalid)
    end
  end
  it 'Should flash a message saying the username is taken when the username exists in the database.' do
    post :create, user: testing345[0]
    post :create, user: testing345[1]
    username = testing345[0][:username]
    expect(flash[:notice]).to match("Username, \'#{username}\' has already been taken")
  end
  it 'Should flash a message saying the account was created if they are valid entries' do
    testing567.each do |testData|
      post :create, user: testData
      username = testData[:username]
      expect(flash[:notice]).to match("Account with Username \'#{username}\' has been created")
    end
  end
  it 'Should flash a message if user successfully joins a room' do
    test_user = User.create_user!(test_valid)
    request.session[:session_token] = test_user.session_token
    room_test = Room.create(name: 'alphabravo123')
    post :join_room, user: {room_id: room_test.invitation_token}
    expect(flash[:notice]).to match('You have successfully joined the room')
  end
  it 'Should flash a message if user fails to join a room because of incorrect invitation code' do
    test_user = User.create_user!(test_valid)
    request.session[:session_token] = test_user.session_token
    post :join_room, user: {room_id: '0'}
    expect(flash[:notice]).to match('Invitation token invalid!')
  end
  it 'Should flash a message if user fails to join a room because of no invitation code' do
    test_user = User.create_user!(test_valid)
    request.session[:session_token] = test_user.session_token
    post :join_room, user: {room_id: ''}
    expect(flash[:notice]).to match('Invitation token invalid!')
  end
  # it 'should allow user to draw a card' do
  #   Card.create_deck_for_room(1)
  #   test_user = User.create_user!(test_valid)
  #   request.session[:session_token] = test_user.session_token
  #   post :draw_card
  #   @hand = Hand.where(:user_id => @current_user.id, :room_id => 1)
  #   expect(@hand).not_to be_empty
  # end

end




