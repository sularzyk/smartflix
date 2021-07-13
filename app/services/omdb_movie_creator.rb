require 'httparty'

class OmdbMovieCreator

  include HTTParty

  omdb_api_key = ENV['OMDB_API_KEY']
  base_uri "http://www.omdbapi.com/?apikey=#{omdb_api_key}"

  def initialize(title)
    @title = title
  end

  def call
    add_movie_to_the_db
  end

  def prepare_data_from_api
    data = self.class.get('&t', query: {t: title})
    data.parsed_response.transform_keys(&:underscore).symbolize_keys.except(:response)
  end

  def add_movie_to_the_db
    movie_data = prepare_data_from_api
    movie = Movie.new(movie_data.except(:type))
    movie.movie_type = movie_data[:type]
    movie.save!
  end

  private

  attr_reader :title

end