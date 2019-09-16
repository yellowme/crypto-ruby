module Crypto
  class Encryptor
    def self.encrypt(options, secret)
      return options[:value] if options[:value].blank?

      Crypto::Crypt.encrypt(options[:value], secret)
    end

    def self.decrypt(options, secret)
      return options[:value] if options[:value].blank?

      Crypto::Crypt.decrypt(options[:value], secret)
    end
  end
end
