FactoryBot.define do
  factory :subscriber do
    email { Faker::Internet.email }
    product
  end
end
