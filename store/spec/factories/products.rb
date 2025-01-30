FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    inventory_count { Faker::Number.within(range: 1..9999) }
  end

  trait :out_of_stock do
    inventory_count { 0 }
  end

  trait :in_stock do
    inventory_count { Faker::Number.within(range: 1..9999) }
  end

  trait :with_1_subscriber do
    after(:build) do |product|
      product.subscribers << FactoryBot.create(:subscriber, product: product)
    end
  end

  trait :with_2_subscribers do
    after(:build) do |product|
      product.subscribers = create_list(:subscriber, 2, product: product)
    end
  end
end
