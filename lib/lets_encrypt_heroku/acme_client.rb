
module LetsEncryptHeroku
  class AcmeClient

    attr_accessor :email, :private_key

    def initialize(email, private_key)
      @email, @private_key = email, private_key
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
        binding.pry
      end
    end

    def request_certificates(domains)
      request = Acme::Client::CertificateRequest.new(names: domains)
      certificate = client.new_certificate(request)
    end

    private

    def client
      @client ||= Acme::Client.new(private_key: private_key, endpoint: 'https://acme-v01.api.letsencrypt.org/').tap { register }
    rescue StandardError => e
      binding.pry
    end

    def register
      registration = client.register(contact: email)
      registration.agree_terms
    rescue
      binding.pry
    end

  end
end
