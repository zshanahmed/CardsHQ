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
  #https://stackoverflow.com/questions/6040479/rspec-testing-redirect-to-back
  before(:each) do
    request.env["HTTP_REFERER"] = "where_i_came_from"
  end

  it 'Should flash a message "invalid entry" if username, password, or email is blank' do
    post :create, :user=>{:username=>'', :password=>'', :email=>''}
  end

end