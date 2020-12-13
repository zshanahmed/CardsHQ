require 'spec_helper'
require 'rails_helper'

describe UsersController do
  login_user
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

  before(:each) do
    @test_room = Room.create!({name: "silly_room"})
    @current_user = subject.set_current_user
    @current_user.save
  end

  after(:all) do
    DatabaseCleaner.clean
  end

  it 'Should flash a message if user successfully joins a room' do
    post :join_room, user: {room_id: @test_room.invitation_token}
    expect(flash[:success]).to match('You have successfully joined the room')
  end
  it 'Should flash a message if user fails to join a room because of incorrect invitation code' do
    post :join_room, user: {room_id: '0'}
    expect(flash[:notice]).to match('Invitation token invalid!')
  end
  it 'Should flash a message if user fails to join a room because of no invitation code' do
    post :join_room, user: {room_id: ''}
    expect(flash[:notice]).to match('Invitation token invalid!')
  end
  it 'should allow user to draw a card' do
    Card.create_deck_for_room(@test_room.id)
    #create a user
    @current_user.room_id = @test_room.id
    post :join_room, user: {room_id: @test_room.invitation_token}
    post :draw_card
    expect(flash[:notice]).to match('Cards added to your hand')
  end
  it 'should flash a message when there is no card available to draw' do
    post :join_room, user: {room_id: @test_room.invitation_token}
    post :draw_card
    expect(flash[:notice]).to match('No cards available to draw')
  end
end




