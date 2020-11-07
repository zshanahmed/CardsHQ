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

  it 'Should flash a message "invalid entry" if username is blank or nil' do
    post :create, :user=>{:username=>'', :password=>'123'}
    expect(flash[:notice]).to be 'Invalid user-id/password combination.'
  end
  it 'Should flash a message "invalid entry" if password is blank or nil' do
    post :create, :user=>{:username=>'anc', :password=>''}
    expect(flash[:notice]).to be 'Invalid user-id/password combination.'
  end
  it 'Should flash a message login successful if username and password are correct' do
    post :create, :user=>{:username=>'GrumpyBunny', :password=>'123'}
    expect(flash[:notice]).to be 'successful'
  end

end
