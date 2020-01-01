module Crypto
  class Commons
    SALT_SPLITTER = '$$'.freeze

    def self.encrypt(text, secret = Crypto.secret_key_base.to_s, cipher: 'aes-256-gcm')
      text = text.to_s unless text.is_a? String

      len   = ActiveSupport::MessageEncryptor.key_len(cipher)
      salt  = SecureRandom.hex len
      key   = ActiveSupport::KeyGenerator.new(secret)
                                         .generate_key salt, len
      crypt = ActiveSupport::MessageEncryptor.new(key, cipher: cipher)
      encrypted_data = crypt.encrypt_and_sign text
      "#{salt}#{SALT_SPLITTER}#{encrypted_data}"
    end

    def self.decrypt(text, secret = Crypto.secret_key_base.to_s, cipher: 'aes-256-gcm')
      salt, data = text.split SALT_SPLITTER

      len   = ActiveSupport::MessageEncryptor.key_len(cipher)
      key   = ActiveSupport::KeyGenerator.new(secret)
                                         .generate_key salt, len
      crypt = ActiveSupport::MessageEncryptor.new(key, cipher: cipher)
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

    def self.checksum512(text)
      text = text.to_s unless text.is_a? String
      Digest::SHA2.new(512).hexdigest(text)
    end

    def self.sha256(secret_key, text)
      OpenSSL::HMAC.hexdigest('sha256', secret_key, text)
    end
  end
end
