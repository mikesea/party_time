require 'spec_helper'

describe "Recommender" do

  let(:client) { Nestling.new("123") }

  let(:artists) { ["Weezer" ] }

  let(:nestling_response) { 
    [{:foreign_ids=>[{"catalog"=>"rdio-us-streaming", 
    "foreign_id"=>"rdio-us-streaming:song:t2731142"}], 
    :artist_id=>"AR633SY1187B9AC3B9", 
    :id=>"SOWQDGD12A58291894", 
    :artist_name=>"Weezer", 
    :title=>"The Girl Got Hot"}]
  }

  context "recommending a tracklist from artists" do
    
    before(:each) do
      Nestling::Playlist.any_instance.stub(:static).and_return(nestling_response)
    end

    it "returns a collection of tracks with populated values" do
      rec = Recommender.recommend_tracks_from_artists(artists, client)
      rec.each do |track|
        track.class.should be Track
        track.artist_name.should_not be nil
        track.title.should_not be nil
        track.rdio_id.should_not be nil
      end
    end

  end
end