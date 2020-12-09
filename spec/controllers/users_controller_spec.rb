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


  it 'Should flash a message if user successfully joins a room' do
    test_user = User.create_user!(test_valid)
    request.session[:session_token] = test_user.session_token
    room_test = Room.create(name: 'alphabravo123')
    post :join_room, user: {room_id: room_test.invitation_token}
    expect(flash[:success]).to match('You have successfully joined the room')
  end
  it 'Should flash a message if user fails to join a room because of incorrect invitation code' do
    test_user = User.create_user!(test_valid)
    request.session[:session_token] = test_user.session_token
    post :join_room, user: {room_id: '0'}
    expect(flash[:notice]).to match('Invitation token invalid!')
  end
  it 'Should flash a message if user fails to join a room because of no invitation code' do
    test_user = User.create!(test_valid)
    byebug
    post :join_room, user: {room_id: ''}
    expect(flash[:notice]).to match('Invitation token invalid!')
  end
  it 'should allow user to draw a card' do
    room_test = Room.create(name: 'testroom123')
    Card.create_deck_for_room(room_test.id)
    #create a user
    test_user = User.create_user!(test_valid)
    request.session[:session_token] = test_user.session_token
    post :join_room, user: {room_id: room_test.invitation_token}
    post :draw_card
    expect(flash[:notice]).to match('Cards added to your hand')
  end
  it 'should flash a message when there is no card available to draw' do
    room_test = Room.create(name: 'testroom123')
    test_user = User.create_user!(test_valid)
    request.session[:session_token] = test_user.session_token
    post :join_room, user: {room_id: room_test.invitation_token}
    post :draw_card
    expect(flash[:notice]).to match('No cards available to draw')
  end
end




