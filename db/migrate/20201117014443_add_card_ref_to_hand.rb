class AddCardRefToHand < ActiveRecord::Migration
  def change
    add_reference :hands, :card, index: true, foreign_key: true
  end
end
