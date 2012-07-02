require 'spec_helper'

describe "Search" do

  context "searching for tracks" do

    let(:query) { "taylor swift - romeo and juliet" }
    let(:rdio_response) { Hashie::Mash.new(
      results: [
        { artist_name: "artist1",
        album_title: "album1",
        title: "title2",
        rdio_id: "t111111"},
        { artist_name: "artist2",
        album_title: "album2",
        title: "title2",
        rdio_id: "t222222"}
      ])}

    before(:each) do
      RdioApi::Client.any_instance.stub(:search).and_return(rdio_response)
    end

    it "returns a collection of tracks with populated values" do
      results = Search.search_for_tracks(query)
      results.each do |r|
        r.class.should be Track
        r.artist_name.should_not be nil
        r.album_title.should_not be nil
        r.title.should_not be nil
        r.rdio_id.should_not be nil
      end
    end

  end
end