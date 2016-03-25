require 'lets_encrypt_heroku/acme_client'

module LetsEncryptHeroku
  class CertificateGenerator

    attr_accessor :endpoint, :email, :private_key, :domains

    def initialize(endpoint, email, private_key, domains)
      @endpoint, @email, @private_key, @domains = endpoint, email, private_key, domains
    end

    def authorize_domains
      domains.each do |domain|
        acme_client.authorize(domain) do |challenge|
          yield domain, challenge_to_hash(challenge)
          acme_client.verify_challenge(challenge)
        end
      end
    end

    def generate
      yield certificates_to_hash(acme_client.request_certificates(domains))
    end

    private

    def acme_client
      @client ||= AcmeClient.new(endpoint, email, private_key)
    end

    def challenge_to_hash(challenge)
      {
        'token': challenge.token,
        'filename': challenge.filename,
        'file_content': challenge.file_content,
        'content_type': challenge.content_type
      }
    end

    def certificates_to_hash(certificates)
      {
        'certificate_chain': certificates.fullchain_to_pem,
        'private_key': certificates.request.private_key.to_pem
      }
    end

  end
end
