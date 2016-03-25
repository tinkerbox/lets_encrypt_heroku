require 'rspec/core/rake_task'
require 'lets_encrypt_heroku'

namespace :lets_encrypt_heroku do

  desc "Authorize domains used by this app"
  task authorize: :environment do
    LetsEncryptHeroku::authorize
  end

  desc "Authorize domains used by this app"
  task generate_certificates: :environment do
    LetsEncryptHeroku::generate_certificates
  end

end
