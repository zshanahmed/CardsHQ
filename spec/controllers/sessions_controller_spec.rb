require 'spec_helper'
require 'rails_helper'

describe SessionsController do

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
  test_valid = {username: 'helloalphatest', password: 'namesbond', email: 'hello@alpha.com'}
  before(:all) do
    DatabaseCleaner.clean
    User.create!({username: "test_user", password: "asdfasdf",:email=>"holisticpanda"})
  end
  it 'Should flash a message "invalid username" if username is blank or nil' do
    post :create, {:username => {:username => ''}, :password => {:password => '123'}}
    expect(flash[:notice]).to match(/Invalid username*/)
  end
  it 'Should flash a message "invalid password" if password is blank or nil' do
    post :create, {:username => {:username => 'Test'}, :password => {:password => ''}}
    expect(flash[:notice]).to match(/Invalid password*/)
  end
  it 'Should flash a message login successful if username and password are correct' do
    fake_results = [double('User')]
    post :create, {:username => {:username => 'test_user'}, :password => {:password => 'asdfasdf'}}
    expect(flash[:success]).to match(/Login Successful*/)
  end
  it 'Should flash a message Invalid user-id or password combination if username and password are not nil' do
    fake_results = [double('User')]
    post :create, {:username => {:username => 'testuser'}, :password => {:password => 'aasdf'}}
    expect(flash[:notice]).to match(/Invalid user-id or password combination.*/)
  end
  it 'Should flash a message You have been logged out' do
    test_user = User.create_user!(test_valid)
    request.session[:session_token] = test_user.session_token
    test_room = Room.create!(name: 'testroom')
    @current_user = User.find_by_session_token(session[:session_token])
    @current_user.room_id = test_room.id
    @current_user.save
    delete :destroy, {:username => {:username => @current_user.username}, :password => {:password => @current_user.password}}
    expect(flash[:notice]).to match(/You have been logged out!/)
  end

end
