class AddCardRefToRoom < ActiveRecord::Migration
  def change
    add_reference :rooms, :card, index: true, foreign_key: true
  end
end
