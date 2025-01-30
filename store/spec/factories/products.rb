FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    inventory_count { 15 }
  end

  trait :with_1_subscriber do
    after(:build) do |product|
      product.subscribers << FactoryBot.create(:subscriber, email: Faker::Internet.email, product: product)
    end
  end

  trait :with_2_subscribers do
    after(:build) do |product|
      product.subscribers << FactoryBot.create(:subscriber, email: Faker::Internet.email, product: product)
      product.subscribers << FactoryBot.create(:subscriber, email: Faker::Internet.email, product: product)
    end
  end
end
