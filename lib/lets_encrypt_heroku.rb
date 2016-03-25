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
      # challenge.token
      # challenge.filename # => ".well-known/acme-challenge/:some_token"
      # challenge.file_content
      # challenge.content_type
      # TODO: save to database
    end

    certificate_generator.generate do |certificate|
      values = { 'LETS_ENCRYPT_CERTIFICATE' => certificate }
      # certificate.request.private_key.to_pem
      # certificate.to_pem
      # certificate.chain_to_pem
      # certificate.fullchain_to_pem
      heroku_platform_client.update_config(values)
    end
  end

end
