require 'spec_helper'
require 'lets_encrypt_heroku'

describe LetsEncryptHeroku do

  describe 'configure' do
    LetsEncryptHeroku.configure do |config|
      config.heroku_platform_api_token = ENV['HEROKU_PLATFORM_API_TOKEN']
      config.heroku_app_name = ENV['HEROKU_APP_NAME']
      config.email = ENV['EMAIL']
      config.domain = ENV['DOMAIN']
      config.private_key = ENV['PRIVATE_KEY']
    end
  end

  it '' do
    require 'platform-api'
    
  end
  
end