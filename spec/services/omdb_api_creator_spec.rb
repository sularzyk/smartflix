require 'rails_helper'

RSpec.describe OmdbMovieCreator do
  describe '#call' do
    subject { described_class.new(omdb_response).call }

    let(:omdb_response) { OmdbApiConnector.new('Harry Potter').call }

    it 'adds movie to db' do
      VCR.use_cassette('movie_creator', record: :new_episodes) do
        expect { subject }.to change(Movie, :count).from(0).to(1)
      end
    end
  end
end
