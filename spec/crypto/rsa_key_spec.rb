require 'spec_helper'

RSpec.describe 'Crypto::RSAKey' do
  let(:passphrase) { '12345678' }
  let(:private_key) { """
-----BEGIN RSA PRIVATE KEY-----
MIICXAIBAAKBgQCqGKukO1De7zhZj6+H0qtjTkVxwTCpvKe4eCZ0FPqri0cb2JZfXJ/DgYSF6vUp
wmJG8wVQZKjeGcjDOL5UlsuusFncCzWBQ7RKNUSesmQRMSGkVb1/3j+skZ6UtW+5u09lHNsj6tQ5
1s1SPrCBkedbNf0Tp0GbMJDyR4e9T04ZZwIDAQABAoGAFijko56+qGyN8M0RVyaRAXz++xTqHBLh
3tx4VgMtrQ+WEgCjhoTwo23KMBAuJGSYnRmoBZM3lMfTKevIkAidPExvYCdm5dYq3XToLkkLv5L2
pIIVOFMDG+KESnAFV7l2c+cnzRMW0+b6f8mR1CJzZuxVLL6Q02fvLi55/mbSYxECQQDeAw6fiIQX
GukBI4eMZZt4nscy2o12KyYner3VpoeE+Np2q+Z3pvAMd/aNzQ/W9WaI+NRfcxUJrmfPwIGm63il
AkEAxCL5HQb2bQr4ByorcMWm/hEP2MZzROV73yF41hPsRC9m66KrheO9HPTJuo3/9s5p+sqGxOlF
L0NDt4SkosjgGwJAFklyR1uZ/wPJjj611cdBcztlPdqoxssQGnh85BzCj/u3WqBpE2vjvyyvyI5k
X6zk7S0ljKtt2jny2+00VsBerQJBAJGC1Mg5Oydo5NwD6BiROrPxGo2bpTbu/fhrT8ebHkTz2epl
U9VQQSQzY1oZMVX8i1m5WUTLPz2yLJIBQVdXqhMCQBGoiuSoSjafUhV7i1cEGpb88h5NBYZzWXGZ
37sJ5QsW+sJyoNde3xH8vdXhzU7eT82D6X/scw9RZz+/6rCJ4p0=
-----END RSA PRIVATE KEY-----
"""
  }

  describe 'sign works ok' do
    test_cases = [
      {
        original_chain: '||0|EMPRESA|||APZ-450057199637|0|200.00|1|40||||40|a|846180000400000001|ND||40||||Concepto||||||2|1|T||3|0|0.00||',
        signature: 'WAEYbfSFV/Ru5ccGA5gDjNo4RWKqNVuR/dKclmQFaVb2ThabPN/jzE5mIQHy8s8ii6G833xNvp/2VX5DWQSKV01JoJszrHpSOF34TvyQNO8WmfXR72b2HK+CVYtKX53JNkduj+dx9YjoqVAe5IWxTJrWBkm777VljocqaBUCEi4='
      },
      {
        original_chain: '||40072|EMPRESA|20111111||RAS|90646|9999.99||||1234|||Beneficiario|5678||||||||||||REFCOB|7777||||||||',
        signature: 'Xl8b7wc89X0JLwkwItKoctdOE4SliQ7z2JR/6XxkllkUiRQYQVWpvUeXznHnP3O1+/s+YNJqjK8kYaCZilJmgILKYeuLHTM67i/hJ9IyQHSqeyGSKBJOAJaZ4G5a+kGzIIl87X5rclaAYEEb1GrEM3P5GmUNOhkxan/I9wSVeds='
      },
      {
        original_chain: '||846|XXXXXX|||123456789|90646|11.35|1|40|||||S.A. de C.V.|846180000000000016|||||||Prueba REST||||||123456||T||3||||',
        signature: 'SuTOV+D7xJ3hzre+PDPfLhtBI0PS1ZjxRkDEnFg5Hdy/0I9S/9VthCo/zE4CBgyqR+mBGwUuuIFkjBidgJl7pdPVqalodg/VgLHlpf969qc76qpo918EkGZV3yPhxmL7AJcf4VYJgTXmvqLlYJsjVhzzTPFYe7YNxULZa94loRM='
      }
    ]

    test_cases.each do |test_case|
      context "test case #{test_case[:original_chain]}" do
        subject do
          key = Crypto::RSAKey.new private_key, passphrase
          key.seal(test_case[:original_chain])
        end

        it { expect { subject }.not_to raise_error }
        it { expect(subject).to eq test_case[:signature] }
      end
    end
  end
end
