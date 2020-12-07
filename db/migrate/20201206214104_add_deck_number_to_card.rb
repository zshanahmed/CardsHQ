class AddDeckNumberToCard < ActiveRecord::Migration
  def change
    add_column :cards, :deckNumber, :string
  end
end
