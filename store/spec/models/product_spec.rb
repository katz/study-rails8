require "rails_helper" # 設定ファイルrails_helper.rbを読み込むコードが全テストにあります

RSpec.describe Product, type: :model do # Productモデルのテストコードをブロック内に書いていきます
  it "trueであるとき、trueになること" do
    expect(true).to eq(true)
  end
end
