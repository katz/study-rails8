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
        in_stock_product_1 = FactoryBot.create(:product, :in_stock)
        in_stock_product_2 = FactoryBot.create(:product, :in_stock)
        out_of_stock_product = FactoryBot.create(:product, :out_of_stock)

        expect(Product.in_stock).to contain_exactly(in_stock_product_1, in_stock_product_2)
      end
    end

    context "どの商品も在庫なしの場合" do
      it "空配列を返すこと" do
        FactoryBot.create(:product, :out_of_stock)

        expect(Product.in_stock).to eq([])
      end
    end
  end
end
