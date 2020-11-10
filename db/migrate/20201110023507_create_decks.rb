class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.string :suit
      t.string :rank

      t.timestamps null: false
    end
  end
end
