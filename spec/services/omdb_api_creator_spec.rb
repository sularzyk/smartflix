# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OmdbMovieCreator do
  describe '#call' do
    subject(:omdb_movie_creator) { described_class.new(omdb_response).call }

    let(:omdb_response) { OmdbApiConnector.new('Harry Potter').get_movie_by_title }

    it 'adds movie to db' do
      VCR.use_cassette('movie_creator', record: :new_episodes) do
        expect { omdb_movie_creator }.to change(Movie, :count).from(0).to(1)
      end
    end
  end
end