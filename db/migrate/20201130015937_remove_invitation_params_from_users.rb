class RemoveInvitationParamsFromUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :token, :string
    add_column :users, :secret, :string
    add_column :users, :profile_image, :string
    remove_column :users, :invited_by_id
    remove_column :users, :invitations_count
    remove_column :users, :invitation_limit
    remove_column :users, :invited_by_type
    remove_column :users, :invitation_sent_at
    remove_column :users, :invitation_accepted_at
    remove_column :users, :invitation_created_at
    remove_column :users, :image
  end
end
