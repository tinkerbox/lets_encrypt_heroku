# Let's Encrypt Heroku

SSL certificates from [Let's Encrypt](https://letsencrypt.org/) expire within 3 months and are a pain to cycle manually, especially for rails apps on Heroku, via [SSL Endpoint](https://devcenter.heroku.com/articles/ssl-endpoint). This gem provides two solutions:

* Approving domains and generating certificate chains with Let's Encrypt servers; and
* Updating certificates on Heroku's SSL Endpoint for custom domains.

This README.md is still a work in progress.

## Usage

Once you're set up, this is all you have to do with your Heroku app:

    $ heroku run rake lets_encrypt_heroku:authorize
    
    $ heroku run rake lets_encrypt_heroku:generate_certificates

Or you could do both at the same time:

    $ heroku run rake lets_encrypt_heroku:authorize_and_generate_certificates

## Getting Started

Install the gem:

    gem "lets_encrypt_heroku"

Generate migrations for storing the challenges:

    $ rake lets_encrypt_heroku:install:migrations
    $ rake db:migrate

You should already have your Heroku SSL Endpoint set up, and your custom domains configured before your proceed. Also, if you haven't done so already, as you will need the token for the next step:

    $ heroku plugins:install git@github.com:heroku/heroku-oauth.git
    $ heroku authorizations:create -d "Platform API token"

Manage your configuration in config/initializers/lets_encrypt_heroku.rb file:

    LetsEncryptHeroku.configure do |config|
      config.heroku_platform_api_token = ''
      config.heroku_app_name = ''
      config.heroku_ssl_name = ''
      config.email = ''
      config.domain = ''
      config.private_key = ''
    end

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

## License

Licensed under the MIT license, see the separate LICENSE.txt file.
