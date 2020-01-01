require 'spec_helper'

RSpec.describe 'Crypto::Commons' do
  let(:value) { '19999552059' }

  describe 'encrypt working ok' do
    subject do
      Crypto::Commons.encrypt(value, 'secret')
    end

    it { expect { subject }.not_to raise_error }
  end

  describe 'encrypt working ok without secret' do
    subject do
      Crypto::Commons.encrypt(value, 'secret')
    end

    it { expect { subject }.not_to raise_error }
  end

  describe 'decrypt working ok' do
    before do
      @encrypted_value = Crypto::Commons.encrypt(value)
    end

    subject do
      Crypto::Commons.decrypt(@encrypted_value)
    end

    it { expect { subject }.not_to raise_error }
    it { expect(subject).to eq value }
  end

  describe 'decrypt working ok without secret' do
    before do
      @encrypted_value = Crypto::Commons.encrypt(value)
    end

    subject do
      Crypto::Commons.decrypt(@encrypted_value)
    end

    it { expect { subject }.not_to raise_error }
    it { expect(subject).to eq value }
  end

  describe 'md5_digest working ok' do
    subject do
      Crypto::Commons.md5_digest(value)
    end

    it { expect { subject }.not_to raise_error }
  end

  describe 'hash working ok' do
    subject do
      Crypto::Commons.hash(value)
    end

    it { expect { subject }.not_to raise_error }
  end

  describe 'hash_compare working ok' do
    let(:hashed_value) { Crypto::Commons.hash(value) }

    subject do
      Crypto::Commons.hash_compare(hashed_value, value)
    end

    it { expect { subject }.not_to raise_error }
    it { expect(subject).to be true }
  end

  describe 'checksum working ok' do
    let(:checksum_value) { Crypto::Commons.checksum(value) }

    subject do
      Crypto::Commons.checksum(value)
    end

    it { expect { subject }.not_to raise_error }
    it { expect(subject).to eq checksum_value }
  end

  describe 'checksum512 working ok' do
    let(:checksum_value) { Crypto::Commons.checksum512(value) }

    subject do
      Crypto::Commons.checksum512(value)
    end

    it { expect { subject }.not_to raise_error }
    it { expect(subject).to eq checksum_value }
  end

  describe 'sha256 working ok' do
    subject do
      Crypto::Commons.sha256('randomkey', value)
    end

    it { expect { subject }.not_to raise_error }
  end
end
