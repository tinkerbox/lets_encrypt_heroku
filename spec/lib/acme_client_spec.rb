require 'spec_helper'
require 'lets_encrypt_heroku'

describe LetsEncryptHeroku::AcmeClient do

  let(:endpoint) { ENV["ENDPOINT"] }
  let(:email) { ENV["EMAIL"] }
  let(:private_key) { OpenSSL::PKey::RSA.new(ENV['PRIVATE_KEY']) }
  let(:domain_name) { 'www.example.com' }

  subject { LetsEncryptHeroku::AcmeClient.new(endpoint, email, private_key) }

  describe ".authorize" do
    it { expect { |block| subject.authorize(domain_name, &block) }.to yield_with_args }
  end

end