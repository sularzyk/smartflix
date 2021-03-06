# frozen_string_literal: true

require 'httparty'

class OmdbMovieCreator
  include HTTParty

  def initialize(omdb_response)
    @omdb_response = omdb_response
  end

  def call
    omdb_response['Response'] == 'True' ? add_movie_to_the_db : log
  end

  private

  attr_reader :omdb_response

  def log
    title = omdb_response['Title']
    Rails.logger.warn("Movie #{title} does not exist")
  end

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
