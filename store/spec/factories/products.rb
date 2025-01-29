FactoryBot.define do
  factory :product do
    name { "T-shirts" }
    inventory_count { 15 }
  end

  trait :with_1_subscriber do
    after(:build) do |product|
      product.subscribers << FactoryBot.create(:subscriber, email: "user1@example.com", product: product)
    end
  end

  trait :with_2_subscribers do
    after(:build) do |product|
      product.subscribers << FactoryBot.create(:subscriber, email: "user1@example.com", product: product)
      product.subscribers << FactoryBot.create(:subscriber, email: "user2@example.com", product: product)
    end
  end
end
