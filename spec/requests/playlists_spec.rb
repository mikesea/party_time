require 'spec_helper'

describe "Playlists" do
  let!(:playlist) { FactoryGirl.create(:playlist_with_tracks) }
  it "something" do
    raise playlist.inspect
  end

end