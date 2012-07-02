FactoryGirl.define do

  factory :living_social_deal do
    sequence(:long_title) { |n| "$10 off deal #{n}" }
    sequence(:link) { |n| "http://livingsocial.com/deals/#{n}" }
    sequence(:image_url) { |n| "http://livingsocial.com/pic/#{n}" }
    national "true"
    country_code "US"
  end
end