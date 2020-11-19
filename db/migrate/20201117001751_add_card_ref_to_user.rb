class AddCardRefToUser < ActiveRecord::Migration
  def change
    add_reference :users, :card, index: true, foreign_key: true
  end
end
