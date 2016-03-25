require 'spec_helper'
require 'lets_encrypt_heroku'

describe LetsEncryptHeroku::HerokuPlatformClient do

  let(:token) { ENV["HEROKU_PLATFORM_API_TOKEN"] }
  let(:app_name) { ENV["HEROKU_APP_NAME"] }
  let(:ssl_name) { ENV["HEROKU_SSL_NAME"] }

  subject { LetsEncryptHeroku::HerokuPlatformClient.new(token, app_name, ssl_name) }

  # describe ".ssl_endpoints" do
  #   it { expect(subject.update_ssl_endpoint).to eq(true) }
  # end

end