require 'spec_helper'
require 'rails_helper'

RSpec.describe Room, type: :model do
  after(:all) do
    DatabaseCleaner.clean
  end
  test = {name: 'test100'}
  it 'should set an invitation when a room is created successfully' do
    test_room = Room.create!(test)
    expect(test_room[:invitation_token]).not_to be nil
  end
end
