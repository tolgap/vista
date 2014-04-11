FactoryGirl.define do
  factory :website do

    name { Faker::Internet.domain_word }
    version { "3.#{Faker::Number.number(1)}.#{Faker::Number.number(1)}" }
    blog_name { name.titleize }
    has_errors false
    has_update { [true, false].sample }
    server nil

    factory :website_with_plugins do

      after(:create) do |website|
        10.times do
          website.plugins << create(:plugin, website: website)
        end
      end

    end

  end
end