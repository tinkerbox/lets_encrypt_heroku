require 'acme/client'

module LetsEncryptHeroku
  class AcmeClient

    attr_accessor :endpoint, :email, :private_key

    def initialize(endpoint, email, private_key)
      @endpoint, @email, @private_key = endpoint, email, private_key
    end

    def authorize(domain)
      yield client.authorize(domain: domain).http01
    end

    def verify_challenge(challenge)
      challenge.request_verification

      5.times do
        break if challenge.verify_status != 'pending'
        sleep(2)
      end

      if challenge.verify_status == 'valid'
        return true
      else
        # TODO: log that challenge failed
      end
    end

    def request_certificates(domains)
      request = Acme::Client::CertificateRequest.new(names: domains)
      certificate = client.new_certificate(request)
    end

    private

    def client
      @client ||= Acme::Client.new(private_key: private_key, endpoint: LetsEncryptHeroku.configuration.endpoint)
      registration = @client.register(contact: email)
      registration.agree_terms
      @client
    rescue Acme::Client::Error::Malformed => e
      # TODO: log e.message, typically it is just that the registration key was previously registered
      @client
    end

  end
end
