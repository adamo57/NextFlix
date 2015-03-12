class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.integer :friend1_id
      t.integer :friend2_id

      t.timestamps null: false
    end
    add_index :friends, :friend1_id
    add_index :friends, :friend2_id
    add_index :friends, [:friend1_id, :friend2_id], unique: true

  end
end
