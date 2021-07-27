require 'httparty'

class OmdbMovieCreator

  include HTTParty

  def initialize(omdb_response)
    @omdb_response = omdb_response
  end

  def call
    add_movie_to_the_db
  end

  private

  attr_reader :omdb_response

  def add_movie_to_the_db
    movie_data = prepare_data_from_api
    movie = Movie.new(movie_data.except(:type))
    movie.movie_type = movie_data[:type]
    movie.save!
  end

  def prepare_data_from_api
    omdb_response.parsed_response.transform_keys(&:underscore).symbolize_keys.except(:response)
  end

end