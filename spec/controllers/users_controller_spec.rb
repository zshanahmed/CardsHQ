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

  it 'Should flash a message "invalid entry" if username is blank or nil' do
    post :create, :user=>{:username=>'', :password=>'', :email=>''}
    expect(flash[:notice]).to be "Invalid entry in one of the textboxes"
    post :create, :user=>{:username=>nil, :password=>nil, :email=>nil}
    expect(flash[:notice]).to be "Invalid entry in one of the text-boxes"
  end

end