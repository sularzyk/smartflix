class CreateMovieWorker

  include Sidekiq::Worker
  sidekiq_options queue: :movies, retry: false

  def perform(title)
    api_response = OmdbApiConnector.new(title).call
    OmdbMovieCreator.new(api_response).call
  end

end
