module LetsEncryptHeroku
  class HerokuPlatformClient

    def initialize(token, app)
      @token, @app = token, app
    end

    def update_ssl_endpoint(values = {})
      if endpoint
        heroku.ssl_endpoint.update(@app, endpoint, values)
      else
        heroku.ssl_endpoint.create(@app, values)
      end
    end

    private

    def heroku
      @heroku ||= PlatformAPI.connect_oauth(@token)
    end

    def endpoint
      list = heroku.ssl_endpoint.list(@app)
      binding.pry
      heroku.ssl_endpoint.info(@app, list)
    end

  end
end
