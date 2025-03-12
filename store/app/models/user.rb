class User < ApplicationRecord
  include UserAuthByArgon2id

  has_secure_password_by_argon2id
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
