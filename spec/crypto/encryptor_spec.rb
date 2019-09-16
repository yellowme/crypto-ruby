require 'spec_helper'

RSpec.describe 'Crypto::Encryptor' do
  let(:options) { { value: '19999552059' } }

  describe 'encrypt working ok' do
    subject do
      Crypto::Encryptor.encrypt(options, 'secret')
    end

    it { expect { subject }.not_to raise_error }
  end

  describe 'decrypt working ok' do
    before do
      @encrypted_options = { value: Crypto::Encryptor.encrypt(options, 'secret') }
    end

    subject do
      Crypto::Encryptor.decrypt(@encrypted_options, 'secret')
    end

    it { expect { subject }.not_to raise_error }
    it { expect(subject).to eq options[:value] }
  end
end
