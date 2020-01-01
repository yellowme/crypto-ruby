$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "crypto/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "crypto-ruby"
  spec.version     = Crypto::VERSION
  spec.date        = '2019-12-10'
  spec.summary     = "Crypto is Yellowme's ruby crypto & security utilities gem"
  spec.description = "Crypto is Yellowme's ruby crypto & security utilities gem"
  spec.files       = ["lib/crypto.rb"]
  spec.authors     = ["Yellowme"]
  spec.email       = 'hola@yellowme.mx'
  spec.homepage    = 'https://github.com/yellowme/crypto-ruby'
  spec.license      = 'MIT'

  spec.add_dependency "bcrypt", "~> 3.1.7"
  spec.add_dependency 'activesupport', '~> 5.0'
  spec.add_dependency "activemodel", "~> 5.2.0"

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "simplecov"
end
