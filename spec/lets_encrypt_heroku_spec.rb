require 'spec_helper'
require 'lets_encrypt_heroku'

describe LetsEncryptHeroku do

  describe '#configure' do

    before do
      LetsEncryptHeroku.configure do |config|
        config.heroku_platform_api_token = ENV['HEROKU_PLATFORM_API_TOKEN']
        config.heroku_app_name = ENV['HEROKU_APP_NAME']
        config.heroku_ssl_name = ENV['HEROKU_SSL_NAME']
        config.endpoint = ENV['ENDPOINT']
        config.email = ENV['EMAIL']
        config.domain = ENV['DOMAIN']
        config.private_key = OpenSSL::PKey::RSA.new(ENV['PRIVATE_KEY'])
      end
    end


    it 'has a working certificate generate client' do
      expect(LetsEncryptHeroku.certificate_generator).not_to be_nil
    end

    it 'has a working heroku platform api client' do
      expect(LetsEncryptHeroku.heroku_platform_client).not_to be_nil
    end

  end

end