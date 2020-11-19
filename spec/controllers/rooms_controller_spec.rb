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

  test1 = {name: 'testroom123'}
  test2 = {name: ''}
  test_valid = {username: 'helloalphatest', password: 'namesbond', email: 'hello@alpha.com'}
  room_test = {name: 'alphatest123'}
  before(:each) do
    test_user = User.create_user!(test_valid)
    request.session[:session_token] = test_user.session_token
  end

  it 'Should flash a message when room is successfully created' do
    post :create, room: test1
    expect(flash[:notice]).to match("Room #{test1[:name]} was created successfully")
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

  it 'Should flash a message when room is destroyed' do
    test_room = Room.create(room_test)
    @current_user = User.find_by_session_token(session[:session_token])
    @current_user.room_id = test_room.id
    delete :destroy, {name: room_test}
    expect(flash[:notice]).to match(/Room destroyed successfully/)
  end
end
