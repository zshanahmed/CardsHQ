require 'spec_helper'
require 'rails_helper'

describe User do

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

  it 'should create from provider data' do

    omniauth_hash_fb = { 'provider' => 'facebook',
                         'uid' => '12345',
                         'info' => {
                             'name' => 'test',
                             'email' => 'test@testsomething.com'
                         },
                         'extra' => {'raw_info' =>
                                         { 'location' => 'Chicago'
                                         }
                         }
    }
    user = User.create_from_provider_data(omniauth_hash_fb)
    expect(user.username).not_to be(nil)
    expect(user.email).not_to be(nil)
  end
end
