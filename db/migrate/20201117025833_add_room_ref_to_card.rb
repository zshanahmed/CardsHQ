class AddRoomRefToCard < ActiveRecord::Migration
  def change
    add_reference :cards, :room, index: true, foreign_key: true
  end
end
