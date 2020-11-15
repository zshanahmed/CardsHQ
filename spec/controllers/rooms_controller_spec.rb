require 'rails_helper'

describe RoomsController do

  test1 = {name: 'testroom123'}
  test2 = {name: ''}

  it 'Should flash a message when room is successfully created' do
    post :create, room: test1
    expect(flash[:notice]).to match("Room #{test1[:name]} was created successfully")
  end

  it 'Should flash a message when no name is provided for room' do
    post :create, room: test2
    expect(flash[:notice]).to match('Room name cannot be empty')
  end

  it 'Should flash a message if room name already taken' do
    post :create, room: test1
    post :create, room: test1
    expect(flash[:notice]).to match('Room name already taken')
  end

end