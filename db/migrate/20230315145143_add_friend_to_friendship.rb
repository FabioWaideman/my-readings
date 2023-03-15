class AddFriendToFriendship < ActiveRecord::Migration[7.0]
  def change
    add_column :friendships, :friend_id, :integer
  end
end
