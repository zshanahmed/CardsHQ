class CreateHands < ActiveRecord::Migration
  def change
    create_table :hands do |t|
      t.string :suit
      t.string :rank

      t.timestamps null: false
    end
  end
end
