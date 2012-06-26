FactoryGirl.define do
  factory :track do
    sequence(:artist_name) { |n| "artist_#{n}" }
    sequence(:title) { |n| "title_#{n}" }
    sequence(:rdio_id) { |n| "#{n}" }
  end
end