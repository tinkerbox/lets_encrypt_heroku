require 'platform-api'

module LetsEncryptHeroku
  class HerokuPlatformClient

    def initialize(token, app, ssl_name)
      @token, @app, @ssl_name = token, app, ssl_name
    end

    def update_ssl_endpoint(values = {})
      heroku.ssl_endpoint.update(@app, @ssl_name, values)
    end

    private

    def heroku
      @heroku ||= ::PlatformAPI.connect_oauth(@token)
    end

  end
end
