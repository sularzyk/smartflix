# frozen_string_literal: true

require 'httparty'

class OmdbApiConnector
  include HTTParty

  omdb_api_key = ENV['OMDB_API_KEY']
  base_uri "http://www.omdbapi.com/?apikey=#{omdb_api_key}"

  def initialize(title)
    @title = title
  end

  def get_movie_by_title
    self.class.get('&t', query: { t: @title })
  end

end
