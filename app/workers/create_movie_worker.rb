class CreateMovieWorker

  include Sidekiq::Worker
  sidekiq_options queue: :movies, retry: false

  def perform(title)
    OmdbMovieCreator.new(title).call
  end

end
