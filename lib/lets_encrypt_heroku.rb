require 'lets_encrypt_heroku/version'
require 'lets_encrypt_heroku/configuration'
require 'lets_encrypt_heroku/certificate_generator'
require 'lets_encrypt_heroku/heroku_platform_client'
require 'lets_encrypt_heroku/challenge_engine'

begin
  require 'pry'
  require 'dotenv'
  Dotenv.load
rescue LoadError
end

module LetsEncryptHeroku

  class << self
    attr_writer :configuration
  end

  def self.root
    File.expand_path '../..', __FILE__
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end

  def self.authorize
    certificate_generator.authorize_domains do |domain, challenge|
      LetsEncryptHeroku::ChallengeRecord.create!(challenge)
    end
  end

  def self.generate_certificates
    certificate_generator.generate do |certificates|
      puts certificates.inspect
      heroku_platform_client.update_ssl_endpoint(certificates)
    end
  end

  private

  def self.certificate_generator
    @certificate_generator ||= CertificateGenerator.new(LetsEncryptHeroku.configuration.endpoint, LetsEncryptHeroku.configuration.email, LetsEncryptHeroku.configuration.private_key, [LetsEncryptHeroku.configuration.domain])
  end

  def self.heroku_platform_client
    @heroku_platform_client ||= HerokuPlatformClient.new(LetsEncryptHeroku.configuration.heroku_platform_api_token, LetsEncryptHeroku.configuration.heroku_app_name, LetsEncryptHeroku.configuration.heroku_ssl_name)
  end

end
