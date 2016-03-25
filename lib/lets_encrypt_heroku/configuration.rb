module LetsEncryptHeroku
  class Configuration
    attr_accessor :heroku_platform_api_token, :heroku_app_name
    attr_accessor :email, :domain, :private_key
  end
end
