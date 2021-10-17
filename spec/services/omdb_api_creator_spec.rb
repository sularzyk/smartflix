# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OmdbMovieCreator do
  describe '#call' do
    subject(:omdb_movie_creator) { described_class.new(omdb_response).call }

    context 'when a movie exists' do
      let(:omdb_response) { OmdbApiConnector.new('Harry Potter').get_movie_by_title }

      it 'adds movie to db' do
        VCR.use_cassette('movie_creator', record: :new_episodes) do
          expect { omdb_movie_creator }.to change(Movie, :count).from(0).to(1)
        end
      end
    end

    context 'when a movie does not exist' do
      let(:omdb_response) { OmdbApiConnector.new('pnfbgiorgbi').get_movie_by_title }
      let(:title) { omdb_response['Title'] }

      it 'does not add movie to db' do
        VCR.use_cassette('nonexistent_movie', record: :new_episodes) do
          expect { omdb_movie_creator }.not_to change(Movie, :count)
        end
      end

      it 'logs a warning' do
        VCR.use_cassette('nonexistent_movie', record: :new_episodes) do
          expect(Rails.logger).to receive(:warn).with("Movie #{title} does not exist")
          subject
        end
      end
    end

  end
end
