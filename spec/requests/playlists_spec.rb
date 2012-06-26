require 'spec_helper'

describe "Playlists" do
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
  end

end