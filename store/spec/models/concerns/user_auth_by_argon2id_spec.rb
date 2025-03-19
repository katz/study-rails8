require 'rails_helper'

RSpec.describe UserAuthByArgon2id do
  before do
    UserAuthByArgon2id.min_cost = true

    class TestUser
      extend ActiveModel::Callbacks
      include ActiveModel::Attributes
      include ActiveModel::Dirty
      include UserAuthByArgon2id

      attribute :password_digest
      has_secure_password_by_argon2id
    end

    class TestVisitor
      extend ActiveModel::Callbacks
      include UserAuthByArgon2id

      attr_accessor :password_digest
      has_secure_password_by_argon2id validations: false
    end
  end

  after do
    Object.send(:remove_const, :TestUser)
    Object.send(:remove_const, :TestVisitor)
  end

  let(:user) { TestUser.new }
  let(:visitor) { TestVisitor.new }
  let(:existing_user) {
    # Simulate loading an existing user from the DB
    user = TestUser.new
    user.password_digest = Argon2::Password.new(profile: :unsafe_cheapest).create('password')
    user.changes_applied
    user
  }

  describe '#has_secure_password_by_argon2id' do
    context 'when it is included' do
      it "automatically include ActiveModel::Validations when validations are enabled" do
        expect(user).to respond_to(:valid?)
      end

      it "don't include ActiveModel::Validations when validations are disabled" do
        expect(visitor).not_to respond_to(:valid?)
      end
    end

    context 'when creating a new user' do
      it "create a new user with validations and valid password/confirmation" do
        user.password = 'secure_password'
        user.password_confirmation = 'secure_password'
        expect(user.valid?(:create)).to be_truthy
      end

      it "create a new user with validation and a spaces only password" do
        user.password = 'a' * 6
        expect(user.valid?(:create)).to be_truthy
      end

      it "create a new user with validation and a spaces only password" do
        user.password = 'a' * 6
        expect(user.valid?(:create)).to be_truthy
      end

      it "create a new user with validation and a blank password" do
        user.password = ''
        expect(user.valid?(:create)).to be_falsey
        expect(user.errors[:password]).to include("can't be blank")
        expect(user.errors.count).to eq(1)
      end

      it "create a new user with validation and a nil password" do
        user.password = nil
        expect(user.valid?(:create)).to be_falsey
        expect(user.errors[:password]).to include("can't be blank")
        expect(user.errors.count).to eq(1)
      end

      it "create a new user with Japanese password" do
        user.password = 'パスワード'
        expect(user.valid?(:create)).to be_truthy
      end

      it "create a new user with validation and a blank password confirmation" do
        user.password = 'secure_password'
        user.password_confirmation = ''
        expect(user.valid?(:create)).to be_falsey
        expect(user.errors[:password_confirmation]).to include("doesn't match Password")
        expect(user.errors.count).to eq(1)
      end

      it "create a new user with validation and a nil password confirmation" do
        user.password = 'secure_password'
        user.password_confirmation = nil
        expect(user.valid?(:create)).to be_truthy
      end

      it "create a new user with validation and an incorrect password confirmation" do
        user.password = 'secure_password'
        user.password_confirmation = 'wrong_password'
        expect(user.valid?(:create)).to be_falsey
        expect(user.errors[:password_confirmation]).to include("doesn't match Password")
        expect(user.errors.count).to eq(1)
      end

      it "resetting password to nil clears the password cache" do
        user.password = 'secure_password'
        expect(user.password_digest).not_to be_nil
        user.password = nil
        expect(user.password_digest).to be_nil
      end
    end

    context "update an existing user" do
      it "update an existing user with validation and no change in password" do
        expect(existing_user.valid?(:update)).to be_truthy
      end

      it "update an existing user with validations and valid password/confirmation" do
        existing_user.password = 'new_secure_password'
        existing_user.password_confirmation = 'new_secure_password'
        expect(existing_user.valid?(:update)).to be_truthy

        existing_user.password = "a" * 72
        existing_user.password_confirmation = "a" * 72
        expect(existing_user.valid?(:update)).to be_truthy
      end

      it "updating an existing user with validation and a blank password" do
        existing_user.password = ''
        expect(existing_user.valid?(:update)).to be_truthy
      end

      it "updating an existing user with validation and a nil password" do
        existing_user.password = nil
        expect(existing_user.valid?(:update)).to be_falsey
        expect(existing_user.errors[:password]).to include("can't be blank")
        expect(existing_user.errors.count).to eq(1)
      end

      it "updating an existing user with validation and a blank password confirmation" do
        existing_user.password = 'new_secure_password'
        existing_user.password_confirmation = ''
        expect(existing_user.valid?(:update)).to be_falsey
        expect(existing_user.errors[:password_confirmation]).to include("doesn't match Password")
        expect(existing_user.errors.count).to eq(1)
      end

      it "updating an existing user with validation and a nil password confirmation" do
        existing_user.password = 'new_secure_password'
        existing_user.password_confirmation = nil
        expect(existing_user.valid?(:update)).to be_truthy
      end

      it "updating an existing user with validation and an incorrect password confirmation" do
        existing_user.password = 'new_secure_password'
        existing_user.password_confirmation = 'wrong_password'
        expect(existing_user.valid?(:update)).to be_falsey
        expect(existing_user.errors[:password_confirmation]).to include("doesn't match Password")
        expect(existing_user.errors.count).to eq(1)
      end

      it "updating an existing user with validation and a correct password challenge" do
        existing_user.password = 'new_secure_password'
        existing_user.password_challenge = 'password'

        expect(existing_user.valid?(:update)).to be_truthy

        p existing_user.password_digest
      end

      it "updating an existing user with validation and a nil password challenge" do
        existing_user.password = 'new_secure_password'
        existing_user.password_challenge = nil
        expect(existing_user.valid?(:update)).to be_truthy
      end

      it "updating an existing user with validation and a blank password challenge" do
        existing_user.password = 'new_secure_password'
        existing_user.password_challenge = ''
        expect(existing_user.valid?(:update)).to be_falsey
        expect(existing_user.errors[:password_challenge]).to include("is invalid")
        expect(existing_user.errors.count).to eq(1)
      end

      it "updating an existing user with validation and an incorrect password challenge" do
        existing_user.password = "new password"
        existing_user.password_challenge = "new password"
        expect(existing_user.valid?(:update)).to be_falsey
        expect(existing_user.errors[:password_challenge]).to include("is invalid")
        expect(existing_user.errors.count).to eq(1)
      end
    end
  end
end
