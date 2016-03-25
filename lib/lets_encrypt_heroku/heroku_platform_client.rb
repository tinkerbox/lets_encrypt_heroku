module LetsEncryptHeroku
  class HerokuPlatformClient

    def initialize(token, app)
      @token, @app = token, app
    end

    def update_config(values = {})
      heroku.config_var.update(@app, values)
    end

    private

    def heroku
      @heroku ||= PlatformAPI.connect_oauth(@token)
    end

  end
end
