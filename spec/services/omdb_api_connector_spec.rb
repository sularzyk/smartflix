require 'rails_helper'

RSpec.describe OmdbApiConnector do
  describe '#call' do
    subject { described_class.new('Hulk').call }

    it 'returns status code 200' do
      VCR.use_cassette('api_connector', record: :new_episodes) do
        expect(subject.code).to eq(200)
      end
    end
  end
end