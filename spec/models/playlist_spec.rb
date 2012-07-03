require 'spec_helper'
require 'ripple'

describe "Playlist" do

  context "working with tracks" do
    let(:track_1) { FactoryGirl.build(:track) }
    let(:track_2) { FactoryGirl.build(:track) }
    let(:playlist) { FactoryGirl.create(:playlist) }

    context "generating a playlist with tracks" do
      
      let(:artists) { ["Weezer", "The Black Keys", "Taylor Swift"] }
      let(:tracks) { FactoryGirl.build_list(:track, 15) }

      context "with valid params" do
        before(:each) do
          Recommender.stub(:recommend_tracks_from_artists).and_return(tracks)
        end

        it "creates a new playlist with tracks" do
          playlist = Playlist.build_from_artists(artists)
          playlist.tracks.count.should == 15
        end
      end
    end

    context "finding tracks" do
      before(:each) do
        playlist.add_track(track_1)
        playlist.add_track(track_2)
      end
      
      it "returns a track when given the rdio_id" do
        playlist.find_track_by_rdio(track_1.rdio_id).should be track_1
      end
    end

    context "adding tracks" do
      it "adds a new track to the playlist given the track hasn't been added" do
        expect { playlist.add_track(track_1) }.to change { playlist.tracks.count }.by(1)
      end

      it "does not add a new track to the playlist if the track is already present" do
        playlist.add_track(track_1)
        expect { playlist.add_track(track_1) }.to_not change { playlist.tracks.count }
      end
    end

    context "removing tracks" do

      before(:each) do
        playlist.add_track(track_1)
        playlist.add_track(track_2)
      end

      it "removes a track from the playlist" do
        pending "Ripple's callbacks and monkeypatching are causing this to fail."
        expect { playlist.remove_track(track_1) }.to change { playlist.tracks.count }.by(-1)
      end

      it "removes a track when given an rdio id" do
        pending "Ripple's callbacks and monkeypatching are causing this to fail."
        count = playlist.tracks.count
        playlist.remove_track_by_rdio(track_1.rdio_id)
        playlist.tracks.count.should == count-1
      end
    end
  end

end