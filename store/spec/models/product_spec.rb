require "rails_helper" # 設定ファイルrails_helper.rbを読み込むコードが全テストにあります

RSpec.describe Product, type: :model do # Productモデルのテストコードをブロック内に書いていきます
  include ActionMailer::TestHelper

  it "trueであるとき、trueになること" do
    expect(true).to eq(true)
  end

  it "subscriberがいないときは、在庫が復活してもメールは送られないこと" do
    product = FactoryBot.create(:product)

    product.update(inventory_count: 0)

    assert_emails 0 do
      product.update(inventory_count: 99)
    end
  end

  it "sends email notifications when back in stock" do
    product = FactoryBot.create(:product, :with_2_subscribers)

    product.update(inventory_count: 0)

    assert_emails 2 do
      product.update(inventory_count: 99)
    end
  end

  describe ".in_stock" do
    context "在庫がある商品があるとき" do
      it "在庫がある商品のみを返すこと" do
        # 作成するProductレコードの個数は1以上のランダムな個数に設定しているが、固定値でもいいかもしれない
        in_stock_products = FactoryBot.create_list(:product, Faker::Number.within(range: 1..100), :in_stock)
        FactoryBot.create_list(:product, Faker::Number.within(range: 1..100), :out_of_stock)

        expect(Product.in_stock).to match_array(in_stock_products)
      end
    end

    context "どの商品も在庫なしの場合" do
      it "空配列を返すこと" do
        FactoryBot.create_list(:product, Faker::Number.within(range: 1..100), :out_of_stock)

        expect(Product.in_stock).to eq([])
      end
    end
  end
end
