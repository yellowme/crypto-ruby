require 'rspec'
require 'simplecov'

require 'crypto'

Crypto.config do |c|
  c.secret_key_base = 'xxxxx'
end

SimpleCov.start
