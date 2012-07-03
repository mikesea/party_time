require 'spec_helper'

describe "TracksController" do
  describe "#show" do

    let(:playlist) { FactoryGirl.create(:playlist_with_tracks) }

    context "fetching tracks" do

      before(:each) do
        get "/playlists/#{playlist.key}/tracks.json"
      end

      it "returns the playlist's tracks" do
        response_json = JSON.parse(response.body)
        response_json.count.should == 5
      end
    end
  end

  describe "#create" do
    context "creating a track" do
      let!(:playlist_count) { empty_playlist.tracks.count }
      let(:empty_playlist) { FactoryGirl.create(:playlist) }
      let(:params) { {:track => { title: "track1", artist_name: "artist1", album_title: "album1", rdio_id: "12356" }}}

      before(:each) do
        post playlist_tracks_url(playlist_id: empty_playlist.key, format: :json), params
      end

      it "returns a 200" do
        response.status.should == 200
      end
    end
  end

end