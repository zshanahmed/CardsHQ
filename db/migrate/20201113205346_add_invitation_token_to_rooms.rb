class AddInvitationTokenToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :invitation_token, :string
  end
end
