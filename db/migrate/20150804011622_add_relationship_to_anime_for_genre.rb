class AddRelationshipToAnimeForGenre < ActiveRecord::Migration
  def change
  	create_table :animes_genres, :id => false do |t|
	  t.references :anime, :null => false
	  t.references :genre, :null => false
	end

	add_index(:animes_genres, [:anime_id, :genre_id], :unique => true)
  end
end
