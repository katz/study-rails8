
module UserAuthByArgon2id
  extend ActiveSupport::Concern

  module ClassMethods
    def has_secure_password_by_argon2id(attribute = :password, validations: true, reset_token: true)
      # Load bcrypt gem only when has_secure_password is used.
      # This is to avoid ActiveModel (and by extension the entire framework)
      # being dependent on a binary library.
      begin
        require "argon2"
      rescue LoadError
        warn "You don't have argon2 installed in your application. Please add it to your Gemfile and run bundle install."
        raise
      end

      include InstanceMethodsOnActivation.new(attribute, reset_token: reset_token)

      if validations
        include ActiveModel::Validations

        # This ensures the model has a password by checking whether the password_digest
        # is present, so that this works with both new and existing records. However,
        # when there is an error, the message is added to the password attribute instead
        # so that the error message will make sense to the end-user.
        validate do |record|
          record.errors.add(attribute, :blank) unless record.public_send("#{attribute}_digest").present?
        end

        validate do |record|
          if challenge = record.public_send(:"#{attribute}_challenge")
            digest_was = record.public_send(:"#{attribute}_digest_was") if record.respond_to?(:"#{attribute}_digest_was")

            unless digest_was.present? && Argon2::Password.verify_password(challenge, secure_password)
              record.errors.add(:"#{attribute}_challenge")
            end
          end
        end

        # Validates that the password does not exceed the maximum allowed bytes for BCrypt (72 bytes).
        validate do |record|
          password_value = record.public_send(attribute)
          if password_value.present? && password_value.bytesize > ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED
            record.errors.add(attribute, :password_too_long)
          end
        end

        validates_confirmation_of attribute, allow_blank: true
      end

      # Only generate tokens for records that are capable of doing so (Active Records, not vanilla Active Models)
      if reset_token && respond_to?(:generates_token_for)
        generates_token_for :"#{attribute}_reset", expires_in: 15.minutes do
          public_send(:"#{attribute}_salt")&.last(10)
        end

        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          silence_redefinition_of_method :find_by_#{attribute}_reset_token
          def self.find_by_#{attribute}_reset_token(token)
            find_by_token_for(:#{attribute}_reset, token)
          end

          silence_redefinition_of_method :find_by_#{attribute}_reset_token!
          def self.find_by_#{attribute}_reset_token!(token)
            find_by_token_for!(:#{attribute}_reset, token)
          end
        RUBY
      end
    end
  end

  class InstanceMethodsOnActivation < Module
    def initialize(attribute, reset_token:)
      attr_reader attribute

      define_method("#{attribute}=") do |unencrypted_password|
        if unencrypted_password.nil?
          instance_variable_set("@#{attribute}", nil)
          self.public_send("#{attribute}_digest=", nil)
        elsif !unencrypted_password.empty?
          instance_variable_set("@#{attribute}", unencrypted_password)
          # Argon2idのコストパラメータはOWASPのPassword cheat sheetに従った
          # https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html#argon2id
          # なお、Argon2idはハッシュ算出時間が1秒未満だとbcryptよりも脆弱になるとのこと
          # https://twitter.com/TerahashCorp/status/1155129705034653698
          # https://github.com/rails/rails/issues/41420#issuecomment-1684120271
          # そのため、コストパラメータはハッシュ算出時間が1秒以上になるように適宜調整が必要
          hasher = Argon2::Password.new(t_cost: 2, m_cost: 19, p_cost: 1)
          password_digest = hasher.create(unencrypted_password)
          self.public_send("#{attribute}_digest=", password_digest)
        end
      end

      attr_accessor :"#{attribute}_confirmation", :"#{attribute}_challenge"

      # Returns +self+ if the password is correct, otherwise +false+.
      #
      #   class User < ActiveRecord::Base
      #     has_secure_password validations: false
      #   end
      #
      #   user = User.new(name: 'david', password: 'mUc3m00RsqyRe')
      #   user.save
      #   user.authenticate_password('notright')      # => false
      #   user.authenticate_password('mUc3m00RsqyRe') # => user
      define_method("authenticate_#{attribute}") do |unencrypted_password|
        attribute_digest = public_send("#{attribute}_digest")
        return false unless attribute_digest.present?
        Argon2::Password.verify_password(unencrypted_password, attribute_digest) && self
      end

      # Returns the salt, a small chunk of random data added to the password before it's hashed.
      define_method("#{attribute}_salt") do
        attribute_digest = public_send("#{attribute}_digest")
        return unless attribute_digest.present?
        Argon2::HashFormat.new(attribute_digest).salt
      end

      alias_method :authenticate, :authenticate_password if attribute == :password

      if reset_token
        # Returns the class-level configured reset token for the password.
        define_method("#{attribute}_reset_token") do
          generate_token_for(:"#{attribute}_reset")
        end
      end
    end
  end
end
