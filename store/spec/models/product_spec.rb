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
end
