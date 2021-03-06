# frozen_string_literal: true

# comment
class MoviesController < ApplicationController
  def show
    title = params[:title].split.map(&:capitalize).join(' ')
    movie = Movie.find_by(title: title)
    if movie
      render json: movie
    else
      CreateMovieWorker.perform_async(title)
      render json: { error: 'Movie was not found' }, status: :not_found
    end
  end
end
