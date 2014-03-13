FactoryGirl.define do
  factory :plugin do
    name { Faker::Name.name.dasherize.underscore }
    version { "#{Faker::Number.number(1)}.#{Faker::Number.number(1)}.#{Faker::Number.number(1)}" }
    status { ["active", "inactive"].sample }
    has_update { [true, false].sample }

    association :website
  end
end