class AddStatusToDecks < ActiveRecord::Migration
  def change
    add_column :decks, :status, :integer , :default => 0
  end
end
