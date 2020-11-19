class AddStatusToCards < ActiveRecord::Migration
  def change
    add_column :cards, :status, :integer
  end
end
