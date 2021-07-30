# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OmdbApiConnector do
  describe '#get_movie_by_title' do
    subject(:omdb_api_connector) { described_class.new('Hulk').get_movie_by_title }

    it 'returns status code 200' do
      VCR.use_cassette('api_connector', record: :new_episodes) do
        expect(omdb_api_connector.code).to eq(200)
      end
    end
  end
end
