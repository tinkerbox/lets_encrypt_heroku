module LetsEncryptHeroku
  class Configuration

    # For talking to Heroku
    attr_accessor :heroku_platform_api_token, :heroku_app_name, :heroku_ssl_name

    # For talking to Let's Encrypt
    attr_accessor :endpoint, :email, :domain, :private_key

    def initialize
      @endpoint = 'https://acme-v01.api.letsencrypt.org/'
    end

  end
end
