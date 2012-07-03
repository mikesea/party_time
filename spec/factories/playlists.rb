FactoryGirl.define do
  factory :playlist, aliases: [:empty_playlist]

  factory :playlist_with_tracks, parent: :playlist do
    after(:create) do |playlist, evaluator|
      5.times do
        track = FactoryGirl.build(:track)
        playlist.tracks << track
      end
      playlist.save
    end
  end

  factory :playlist_with_many_tracks, parent: :playlist do
    after(:create) do |playlist, evaluator|
      50.times do
        track = FactoryGirl.build(:track)
        playlist.tracks << track
      end
      playlist.save
    end
  end
end