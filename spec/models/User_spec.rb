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

  # bad_entry = [{:username=>'', :password=>'', :email=>''},
  #             {:username=>'', :password=>'hello', :email=>'wello'},
  #             {:username=>'sss', :password=>'', :email=>'bbbb'},
  #             {:username=>'rrr', :password=>'blah', :email=>''},
  #             {:username=>'jfj', :password=>'', :email=>''},
  #             {:username=>'', :password=>'', :email=>'kjfj'},
  #             {:username=>'', :password=>'rwer', :email=>''},
  #             {:username=>'    ', :password=>'    ', :email=>'    '},
  #             {:username=>'', :password=>'  ', :email=>'   '},
  #             {:username=>'   ', :password=>'   ', :email=>''},
  #             {:username=>'', :password=>'   ', :email=>''},
  #             {:username=>'', :password=>'', :email=>'   '},
  #             {:username=>'asdfasd', :password=>'big stink', :email=>'fasdfasdf'},
  #             {:username=>'afdsa*', :password=>'vadf', :email=>'asdf'},
  #             {:username=>'RRR&', :password=>'ppp^^^', :email=>'kaf%'}]
  good_entry = [{:username=>'fuzzyBunny', :password=>'bad_password', :email=>'eshaeffer@uiowa.edu'},
               {:username=>'glib_macaque', :password=>'broken_bottle', :email=>'moron@hotmail.com'},
               {:username=>'Beethoven', :password=>'Stupid_passoword', :email=>'great_email@uiowa.edu'}]

  # session_entry = {:username=>'fuzzyBunny', :password=>'bad_password', :email=>'eshaeffer@uiowa.edu'}
end
