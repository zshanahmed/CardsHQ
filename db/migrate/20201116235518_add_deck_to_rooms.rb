class AddDeckToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :deck, :string
  end
end
