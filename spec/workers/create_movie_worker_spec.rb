# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CreateMovieWorker, type: :worker do
  describe '#perform' do
    subject { described_class.new.perform('Hulk')}

    let(:omdb_api_connector) { instance_double(OmdbApiConnector) }
    let(:omdb_movie_creator) { instance_double(OmdbMovieCreator) }
    let(:api_response) { {"Title"=>"Love",
                          "Year"=>"2015",
                          "Rated"=>"TV-MA",
                          "Released"=>"30 Oct 2015",
                          "Runtime"=>"135 min",
                          "Genre"=>"Drama, Romance",
                          "Director"=>"Gaspar Noé",
                          "Writer"=>"Gaspar Noé",
                          "Actors"=>"Aomi Muyock, Karl Glusman, Klara Kristin",
                          "Plot"=>
                            "Murphy is an American living in Paris who enters a highly sexually and emotionally charged relationship with Electra. Unaware of the effect it will have on their relationship, they invite their pretty neighbor into their bed.",
                          "Language"=>"English, French",
                          "Country"=>"France, Belgium",
                          "Awards"=>"2 wins & 1 nomination",
                          "Poster"=>"https://m.media-amazon.com/images/M/MV5BMTQzNDUwODk5NF5BMl5BanBnXkFtZTgwNzA0MDQ2NTE@._V1_SX300.jpg",
                          "Ratings"=>[{"Source"=>"Internet Movie Database", "Value"=>"6.1/10"}, {"Source"=>"Rotten Tomatoes", "Value"=>"40%"}, {"Source"=>"Metacritic", "Value"=>"51/100"}],
                          "Metascore"=>"51",
                          "imdbRating"=>"6.1",
                          "imdbVotes"=>"53,056",
                          "imdbID"=>"tt3774694",
                          "Type"=>"movie",
                          "DVD"=>"N/A",
                          "BoxOffice"=>"$249,083",
                          "Production"=>"N/A",
                          "Website"=>"N/A",
                          "Response"=>"True"} }

    it 'connects with OmdbApi and it creates movie in db' do
      allow(OmdbApiConnector).to receive(:new).with('Hulk').and_return(omdb_api_connector)
      expect(omdb_api_connector).to receive(:get_movie_by_title).and_return(api_response)
      allow(OmdbMovieCreator).to receive(:new).with(api_response).and_return(omdb_movie_creator)
      expect(omdb_movie_creator).to receive(:call)
      subject
    end

  end
end
