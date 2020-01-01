module Crypto
  class Encryptor
    def self.encrypt(options, secret=Crypto.secret_key_base.to_s)
      return options[:value] if options[:value].blank?

      Crypto::Commons.encrypt(options[:value], secret)
    end

    def self.decrypt(options, secret=Crypto.secret_key_base.to_s)
      return options[:value] if options[:value].blank?

      Crypto::Commons.decrypt(options[:value], secret)
    end
  end
end
