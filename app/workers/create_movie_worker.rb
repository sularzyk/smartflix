# frozen_string_literal: true

class CreateMovieWorker
  include Sidekiq::Worker
  sidekiq_options queue: :movies, retry: false

  def perform(title)
    api_response = OmdbApiConnector.new(title).get_movie_by_title
    OmdbMovieCreator.new(api_response).call
  end
end
