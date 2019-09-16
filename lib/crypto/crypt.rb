require 'digest/md5'
require 'active_support/message_encryptor'
require 'active_support/key_generator'
require 'active_support/concern'
require 'active_model/secure_password'
require 'securerandom'
require 'bcrypt'

module Crypto
  class Crypt
    SALT_SPLITTER = '$$'.freeze

    def self.encrypt(text, secret)
      text = text.to_s unless text.is_a? String

      len   = ActiveSupport::MessageEncryptor.key_len
      salt  = SecureRandom.hex len
      key   = ActiveSupport::KeyGenerator.new(secret)
                                         .generate_key salt, len
      crypt = ActiveSupport::MessageEncryptor.new key
      encrypted_data = crypt.encrypt_and_sign text
      "#{salt}#{SALT_SPLITTER}#{encrypted_data}"
    end

    def self.decrypt(text, secret)
      salt, data = text.split SALT_SPLITTER

      len   = ActiveSupport::MessageEncryptor.key_len
      key   = ActiveSupport::KeyGenerator.new(secret)
                                         .generate_key salt, len
      crypt = ActiveSupport::MessageEncryptor.new key
      crypt.decrypt_and_verify data
    end

    def self.hash(text)
      text = text.to_s unless text.is_a? String
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
               BCrypt::Engine.cost
      BCrypt::Password.create(text, cost: cost)
    end

    def self.hash_compare(hash, text)
      password = BCrypt::Password.new(hash)
      password == text
    end

    def self.md5_digest(text)
      text = text.to_s unless text.is_a? String
      Digest::MD5.hexdigest(text)
    end

    def self.checksum(text)
      text = text.to_s unless text.is_a? String
      Digest::SHA2.new(256).hexdigest(text)
    end

    def self.sha256(secret_key, text)
      OpenSSL::HMAC.hexdigest('sha256', secret_key, text)
    end
  end
end
