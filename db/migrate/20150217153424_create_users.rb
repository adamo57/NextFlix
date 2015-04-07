class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.references :pending_friend_requests, index: true

      t.timestamps null: false
    end
  end
end
