module LetsEncryptHeroku
  class Configuration

    # For talking to Heroku
    attr_accessor :heroku_platform_api_token, :heroku_app_name

    # For talking to Let's Encrypt
    attr_accessor :email, :domain, :private_key

    #  For the challenge engine
    attr_accessor :app_root

  end
end
