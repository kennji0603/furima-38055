FactoryBot.define do
  factory :user do
    nickname { 'テスト' }
    email { Faker::Internet.free_email }
    password { Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }
    password_confirmation { password }
    first_name { '太郎' }
    last_name { '山田' }
    first_name_reading { 'タロウ' }
    last_name_reading { 'ヤマダ' }
    birthday { '1940-01-01' }
  end
end
