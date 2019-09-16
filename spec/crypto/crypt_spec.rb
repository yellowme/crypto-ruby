require 'spec_helper'

RSpec.describe 'Crypto::Crypt' do
  let(:value) { '19999552059' }

  describe 'encrypt working ok' do
    subject do
      Crypto::Crypt.encrypt(value, 'secret')
    end

    it { expect { subject }.not_to raise_error }
  end

  describe 'decrypt working ok' do
    before do
      @encrypted_value = Crypto::Crypt.encrypt(value, 'secret')
    end

    subject do
      Crypto::Crypt.decrypt(@encrypted_value, 'secret')
    end

    it { expect { subject }.not_to raise_error }
    it { expect(subject).to eq value }
  end

  describe 'md5_digest working ok' do
    subject do
      Crypto::Crypt.md5_digest(value)
    end

    it { expect { subject }.not_to raise_error }
  end

  describe 'hash working ok' do
    subject do
      Crypto::Crypt.hash(value)
    end

    it { expect { subject }.not_to raise_error }
  end

  describe 'hash_compare working ok' do
    let(:hashed_value) { Crypto::Crypt.hash(value) }

    subject do
      Crypto::Crypt.hash_compare(hashed_value, value)
    end

    it { expect { subject }.not_to raise_error }
    it { expect(subject).to be true }
  end

  describe 'checksum working ok' do
    let(:checksum_value) { Crypto::Crypt.checksum(value) }

    subject do
      Crypto::Crypt.checksum(value)
    end

    it { expect { subject }.not_to raise_error }
    it { expect(subject).to eq checksum_value }
  end

  describe 'sha256 working ok' do
    subject do
      Crypto::Crypt.sha256('randomkey', value)
    end

    it { expect { subject }.not_to raise_error }
  end
end
