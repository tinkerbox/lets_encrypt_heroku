require 'openssl'
require 'acme/client'

module LetsEncryptHeroku
  class CertificateGenerator

    attr_accessor :email, :private_key, :domains

    def initialize(email, private_key, domains)
      @email, @private_key, @domains = email, private_key, domains
    end

    def authorize_domains
      domains.each do |domain|
        acme_client.authorize(domain) do |challenge|
          yield domain, challenge
          acme_client.verify_challenge(challenge)
        end
      end
    end

    def generate
      yield acme_client.request_certificates(domains)
    end

    private

    def acme_client
      @client ||= AcmeClient.new(email, private_key)
    end

  end
end
