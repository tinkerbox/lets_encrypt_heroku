require 'lets_encrypt_heroku/version'
require 'lets_encrypt_heroku/configuration'

begin
  require 'pry'
rescue LoadError
end

module LetsEncryptHeroku

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end

  def run
    certificate_generator = CertificateGenerator.new(LetsEncryptHeroku.configuration.email, LetsEncryptHeroku.configuration.email, LetsEncryptHeroku.configuration.private_key, [LetsEncryptHeroku.configuration.domain])
    heroku_platform_client = HerokuPlatformClient.new(LetsEncryptHeroku.configuration.heroku_platform_api_token, LetsEncryptHeroku.configuration.heroku_app_name)

    certificate_generator.authorize_domains do |domain, challenge|
      binding.pry
      ChallengeRecord.create do |record|
        record.token = token
        record.filename = filename
        record.file_content = file_content
        record.content_type = content_type
      end
    end

    certificate_generator.generate do |certificate|
      binding.pry
      values = {
        certificate_chain: certificate.chain_to_pem,
        private_key: certificate.request.private_key.to_pem
      }
      # certificate.to_pem
      # certificate.fullchain_to_pem
      heroku_platform_client.update_ssl_endpoint(values)
    end
  end

end
