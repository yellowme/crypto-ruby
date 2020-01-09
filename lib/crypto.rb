require 'digest/md5'
require 'active_support/message_encryptor'
require 'active_support/key_generator'
require 'active_support/concern'
require 'active_model/secure_password'
require 'securerandom'
require 'bcrypt'
require 'openssl'
require 'open3'

require 'crypto/commons'
require 'crypto/encryptor'
require 'crypto/rsa_key'

module Crypto
  def self.config
    yield self
  end

  def self.secret_key_base
    @secret_key_base
  end

  def self.secret_key_base=(secret_key_base)
    @secret_key_base = secret_key_base
  end
end
