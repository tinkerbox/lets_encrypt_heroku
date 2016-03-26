require 'lets_encrypt_heroku'

namespace :lets_encrypt_heroku do

  desc "Authorize domains used by this app with Let's Encrypt"
  task authorize: :environment do
    LetsEncryptHeroku::authorize
  end

  desc "Generate certificates and send them to Heroku' SSL Endpoint"
  task generate_certificates: :environment do
    LetsEncryptHeroku::generate_certificates
  end

  desc "Authorize domains with Let's Encrypt and send generated certificates to Heroku's SSL Endpooint"
  task authorize_and_generate_certificates: :environment do
    LetsEncryptHeroku::authorize
    LetsEncryptHeroku::generate_certificates
  end

end
