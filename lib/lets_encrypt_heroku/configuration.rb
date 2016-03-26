module LetsEncryptHeroku
  class Configuration

    # For talking to Heroku
    attr_accessor :heroku_platform_api_token, :heroku_app_name, :heroku_ssl_name

    # For talking to Let's Encrypt
    attr_accessor :endpoint, :email, :domain, :private_key

    def initialize
      @heroku_platform_api_token = ENV['HEROKU_PLATFORM_API_TOKEN']
      @heroku_app_name = ENV['HEROKU_APP_NAME']
      @heroku_ssl_name = ENV['HEROKU_SSL_NAME']

      @endpoint = ENV['ENDPOINT']
      @email = ENV['EMAIL']
      @domain = ENV['DOMAIN']
      @private_key = OpenSSL::PKey::RSA.new(ENV['PRIVATE_KEY']) if ENV['PRIVATE_KEY']
    end

  end
end
