FactoryGirl.define do
  factory :event do
    date Time.now
    name "Mike's Party"
    details "Wine and cheez-wiz party."
    location "123 Fake St."
  end
end