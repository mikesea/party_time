require 'spec_helper'

describe "Playlists" do
  describe "#create" do
    context "creating a new playlist" do
    
      let(:tracks) { FactoryGirl.build_list(:track, 15) }
      let(:params) { {:artists => ["Bon Iver", "Rolling Stones", "The Black Keys", "The Beatles"]}}

      before(:each) do
        Recommender.stub(:recommend_tracks_from_artists).and_return(tracks)
        post playlists_url(format: :json), params
      end

      it "returns a new playlist with 15 tracks" do
        response_json = JSON.parse(response.body)
        response_json['playlist']['tracks'].count.should be 15
      end

      it "returns a Riak-generated key for the playlist" do
        response_json = JSON.parse(response.body)
        response_json['playlist']['key'].should_not be nil
      end
    end
  end

  describe "#show" do
    context "the playlist exists" do
      
      let!(:playlist) { FactoryGirl.create(:playlist_with_tracks) }
      
      before(:each) do
        get playlist_url(playlist.key, format: :json)
      end

      it "returns a json response with the playlist's key" do
        response_json = JSON.parse(response.body)
        response_json.value?(playlist.key).should be_true
      end

      it "returns a json response with the playlist's event details" do
        response_json = JSON.parse(response.body)
        response_json["event"]["date"].should be
        response_json["event"]["details"].should == playlist.event.details
        response_json["event"]["name"].should == playlist.event.name
        response_json["event"]["location"].should == playlist.event.location
      end

      it "returns a json response with the playlist's tracks" do
        response_json = JSON.parse(response.body)
        response_json["tracks"].count.should == playlist.tracks.count
      end

      it "returns a 200 response" do
        response.status.should == 200
      end
    end

    context "the playlist doesn't exist" do
      before(:each) do
        get playlist_url("123", format: :json)
      end

      it "returns a 400 response" do
        response.status.should == 400
      end
    end
  end

end