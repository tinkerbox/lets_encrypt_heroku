require 'spec_helper'
require 'lets_encrypt_heroku'

describe LetsEncryptHeroku::CertificateGenerator do

  let(:endpoint) { ENV["ENDPOINT"] }
  let(:email) { ENV["EMAIL"] }
  let(:private_key) { OpenSSL::PKey::RSA.new(ENV['PRIVATE_KEY']) }
  let(:domain_names) { ['www.example.com'] }

  subject { LetsEncryptHeroku::CertificateGenerator.new(endpoint, email, private_key, domain_names) }

  describe ".authorize_domains" do
    it { expect { |block| subject.authorize_domains(&block) }.to yield_with_args }
  end

end