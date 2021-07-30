# frozen_string_literal: true

class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :year
      t.string :rated
      t.date :released
      t.integer :runtime
      t.string :genre
      t.string :director
      t.string :writer
      t.string :actors
      t.text :plot
      t.string :language
      t.string :country
      t.string :awards
      t.string :poster
      t.text :ratings
      t.integer :metascore
      t.float :imdb_rating
      t.bigint :imdb_votes
      t.string :imdb_id
      t.string :movie_type
      t.date :dvd
      t.string :box_office
      t.string :production
      t.string :website

      t.index ['title'], name: 'index_movies_on_title'
      t.timestamps
    end
  end
end
