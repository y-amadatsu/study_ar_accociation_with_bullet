class CreateMovieActors < ActiveRecord::Migration[5.2]
  def change
    create_table :movie_actors do |t|
      t.integer :actor_id
      t.integer :movie_id

      t.timestamps
    end
  end
end
