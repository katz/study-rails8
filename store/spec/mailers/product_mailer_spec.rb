require "rails_helper"

RSpec.describe ProductMailer, type: :mailer do
  it "trueであるとき、trueになること" do
    expect(true).to eq(true)
  end

  it "in_stock" do
    email = Faker::Internet.email
    product = FactoryBot.create(:product)
    subscriber = FactoryBot.create(:subscriber, product: product, email: email)

    mail = ProductMailer.with(product: product, subscriber: subscriber).in_stock

    expect(mail.subject).to eq("In stock")
    expect(mail.to).to eq([ email ])
    expect(mail.from).to eq([ "from@example.com" ])
    expect(mail.body.encoded).to match("Good news!")
  end
end
