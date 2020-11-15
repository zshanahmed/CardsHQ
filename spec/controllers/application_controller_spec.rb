require 'spec_helper'
require 'rails_helper'

describe ApplicationController do
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

  it "Should have a set_current_user method that runs" do
    expect(subject.set_current_user).to be nil
  end
end
