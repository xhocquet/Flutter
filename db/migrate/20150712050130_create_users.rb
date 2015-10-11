class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.date :last_date_updated
      t.float :mean_rating
      t.integer :number_of_entries
      t.integer :number_of_episodes
      t.integer :time_spent_on_anime
      t.string :avatar
      t.string :cover_image
      t.string :name

      t.timestamps null: false
    end

    create_table :library_entries do |t|
      t.date :last_date_watched
      t.float :rating
      t.integer :episodes_watched
      t.integer :hm_id
      t.integer :times_rewatched
      t.string :status
      t.string :title
      t.string :name

      t.belongs_to :anime, index: true
      t.belongs_to :user, index: true

      t.timestamps null: false
    end

    create_table :animes do |t|
      t.date :end_air_date
      t.date :start_air_date
      t.float :community_rating
      t.integer :episode_count
      t.integer :episode_length
      t.integer :hm_id
      t.integer :mal_id
      t.string :age_rating
      t.string :cover_image_url
      t.string :hm_url
      t.string :show_type
      t.string :status
      t.string :title
      t.text :synopsis
      t.string :slug
      
      t.timestamps null: false
    end

    create_table :genres do |t|
      t.string :name
    end
  end
end
