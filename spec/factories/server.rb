FactoryGirl.define do
  factory :server do
    name { Faker::Internet.domain_suffix }
  end
end