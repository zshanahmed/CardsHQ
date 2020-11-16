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

end
