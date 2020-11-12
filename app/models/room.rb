class Room < ActiveRecord::Base
  belongs_to :user

  def index
    @rooms = Room.all
  end
end
