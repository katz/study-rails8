FactoryBot.define do
  factory :subscriber do
    email { Faker::Internet.unique.email }
    product
  end
end
