class Room < ActiveRecord::Base

  has_many :users

  def index
    @rooms = Room.all
  end
end
