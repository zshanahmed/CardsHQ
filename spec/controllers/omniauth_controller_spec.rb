require 'spec_helper'
require 'rails_helper'

describe Users::OmniauthController do

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

  before do
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:twitter]
    request.env["devise.mapping"] = Devise.mappings[:user] # If using Devise
  end

  describe "#create" do
    it "should successfully create a user with twitter" do
      expect {
        post :twitter, provider: :twitter
      }.to change{ User.count }.by(1)
    end

    it "should successfully create a session with twitter" do
      session[:user].should be_nil
      post :twitter, provider: :twitter
      session[:user].should_not be_nil
    end

    it "should redirect the user to the root url with twitter" do
      post :twitter, provider: :twitter
      response.should redirect_to root_path
    end

    it "should successfully create a user with facebook" do
      expect {
        post :facebook, provider: :facebook
      }.to change{ User.count }.by(1)
    end

    # it "should successfully create a session with facebook" do
    #   session[:user_id].should be_nil
    #   post :facebook, provider: :facebook
    #   session[:user_id].should_not be_nil
    # end

    it "should throw an error when user fails to login with facebook" do
      post :facebook, provider: :facebook
      expect(flash[:error]).to eq 'There was a problem signing you in through Facebook. Please register or try signing in later.'
    end

    it "should redirect the user to the root path with facebook" do
      post :facebook, provider: :facebook
      response.should redirect_to root_path
    end

  end

end