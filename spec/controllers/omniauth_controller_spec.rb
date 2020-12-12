require 'spec_helper'
require 'rails_helper'

describe Users::OmniauthController do
    if RUBY_VERSION >= '2.6.0'
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

    describe '#create' do
      it 'should successfully create a user with twitter' do
        request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:twitter]
        expect {
          post :twitter, provider: :twitter
        }.to change{ User.count }.by(1)
      end

      it 'should redirect the user to the root url with twitter' do
        request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:twitter]
        post :twitter, provider: :twitter
        response.should redirect_to root_path
      end

      it 'should successfully create a user with facebook' do
        request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
        expect {
          post :facebook, provider: :facebook
        }.to change{ User.count }.by(1)
      end


      it 'should throw an error when user fails to login with facebook' do
        request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook_fail]
        post :facebook, provider: :facebook
        expect(flash[:error]).to eq 'There was a problem signing you in through Facebook. Please register or try signing in later.'
      end

      it 'should throw an error when user fails to login with twitter' do
        request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:twitter_fail]
        post :twitter, provider: :twitter
        expect(flash[:error]).to eq 'There was a problem signing you in through Twitter. Please register or try signing in later.'
      end

      it 'should redirect the user to the root path with facebook' do
        request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
        post :facebook, provider: :facebook
        response.should redirect_to root_path
      end

    end
end