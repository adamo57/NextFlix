class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :friend_id
      t.integer :friendOf_id

      t.timestamps null: false
    end
      add_index :friendships, :friend_id
      add_index :friendships, :friendOf_id
      add_index :friendships, [:friend_id, :friendOf_id], unique: true

  end
end
