class CreateUserMovies < ActiveRecord::Migration
  def change
    create_table :user_movies do |t|
      t.integer :movie_id
      t.integer :user_id
      t.boolean :recently_viewed, :default => true
      t.boolean :liked

      t.timestamps null: false
    end
    add_index :user_movies, :user_id
    add_index :user_movies, :movie_id
    add_index :user_movies, [:user_id, :movie_id], unique: true
  end
end
