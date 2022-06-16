FactoryBot.define do
  factory :item do
    name { Faker::Name.initials(number: 40) }
    explanation { Faker::Lorem.sentence }
    price { 500 }
    association :user
    category_id { 2 }
    condition_id { 2 }
    postagetype_id { 2 }
    prefecture_id { 2 }
    preparationday_id { 2 }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
