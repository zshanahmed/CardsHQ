class AddRoomRefToHand < ActiveRecord::Migration
  def change
    add_reference :hands, :room, index: true, foreign_key: true
  end
end
