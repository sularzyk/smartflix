require 'httparty'

class OmdbApiConnector

  include HTTParty

  omdb_api_key = ENV['OMDB_API_KEY']
  base_uri "http://www.omdbapi.com/?apikey=#{omdb_api_key}"

  def initialize(title)
    @title = title
  end

  def call
    connect_with_api
  end

  private

  attr_reader :title

  def connect_with_api
    self.class.get('&t', query: {t: title})
  end

end
