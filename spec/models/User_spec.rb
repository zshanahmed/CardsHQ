require 'spec_helper'
require 'rails_helper'

describe User do
  it 'should create from provider data' do
    user = User.create_from_provider_data(OmniAuth.config.mock_auth[:facebook])
    expect(user.username).not_to be(nil)
    expect(user.email).not_to be(nil)
  end
end
