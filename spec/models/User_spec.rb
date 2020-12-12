require 'spec_helper'
require 'rails_helper'

describe User do
  it 'should create from provider data' do

    # omniauth_hash_fb = { 'provider' => 'facebook',
    #                      'uid' => '12345',
    #                      'info' => {
    #                          'name' => 'test',
    #                          'email' => 'test@testsomething.com'
    #                      },
    #                      'extra' => {'raw_info' =>
    #                                      { 'location' => 'Chicago'
    #                                      }
    #                      }
    # }
    # request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:facebook]
    byebug
    user = User.create_from_provider_data(OmniAuth.config.mock_auth[:facebook])
    expect(user.username).not_to be(nil)
    expect(user.email).not_to be(nil)
  end
end
