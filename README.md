# Let's Encrypt Heroku

SSL certificates from [Let's Encrypt](https://letsencrypt.org/) expire within 3 months and are a pain to cycle manually, especially for rails apps on Heroku, via [SSL Endpoint](https://devcenter.heroku.com/articles/ssl-endpoint). This gem provides two solutions:

* Approving domains and generating certificate chains with Let's Encrypt servers; and
* Updating certificates on Heroku's SSL Endpoint for custom domains.

To accomplish this, the gem relies on two gems:

* https://github.com/unixcharles/acme-client
* https://github.com/heroku/platform-api

This README.md is still a work in progress.

## Usage

Once you're set up, this is all you have to do with your Heroku app:

    $ heroku run rake lets_encrypt_heroku:authorize
    
    $ heroku run rake lets_encrypt_heroku:generate_certificates

Or you could do both at the same time (this is not working yet):

    $ heroku run rake lets_encrypt_heroku:authorize_and_generate_certificates

## Getting Started

Install the gem:

    gem "lets_encrypt_heroku"

Generate migrations for storing the challenges:

    $ rails g lets_encrypt_heroku
    $ rake db:migrate

You should already have your Heroku SSL Endpoint set up, and your custom domains configured before your proceed. Also, if you haven't done so already, as you will need the token for the next steps (note down the key that was generated):

    $ heroku plugins:install git@github.com:heroku/heroku-oauth.git
    $ heroku authorizations:create -d "Platform API token"

Generate a private key to be used on the server, and copy it to your clipboard:

    openssl genrsa 4096 > keyfile.pem
    cat keyfile.pem | pbcopy

I find it useful to manage your configuration using environment variables and use them in the config/initializers/lets_encrypt_heroku.rb file like so:

    LetsEncryptHeroku.configure do |config|
      c.heroku_platform_api_token = ENV['HEROKU_PLATFORM_API_TOKEN']
      c.heroku_app_name = ENV['HEROKU_APP_NAME']
      c.heroku_ssl_name = ENV['HEROKU_SSL_NAME']
      c.email = ENV['EMAIL']
      c.domain = ENV['DOMAIN']
      c.private_key = OpenSSL::PKey::RSA.new(ENV['PRIVATE_KEY']) if ENV['PRIVATE_KEY']
    end

Rmember to paste the generated private key into Heroku's 'PRIVATE_KEY' environment variable. If using the CLI, ensure it is wrapped in quotes to preserve the newlines in the private key:

    $ heroku config:add PRIVATE_KEY="-----BEGIN RSA PRIVATE KEY-----
    > ...
    > -----END RSA PRIVATE KEY-----
    > "

Mount the challenge engine in your config/routes.rb file:

    mount LetsEncryptHeroku::ChallengeEngine, at: '/.well-known'

Now deploy your app so that you can start accepting challenges with the challenge engine.

## Maintainers

* [Jaryl Sim](https://github.com/jaryl), [Tinkerbox Studios](https://www.tinkerbox.com.sg/)

## Contributing

* Fork it
* Create your feature branch (git checkout -b my-new-feature)
* Commit your changes (git commit -am 'Added some feature')
* Push to the branch (git push origin my-new-feature)
* Create new Pull Request

## Roadmap

* allow creation of the SSL Endpoint and auto-set config var for first-time users
* figure out better way to handle private keys, and generated certificates
* remove challenge records after a certain time with a rake task
* more tests, with rspec, webmock, etc

## License

Licensed under the MIT license, see the separate LICENSE.txt file.
