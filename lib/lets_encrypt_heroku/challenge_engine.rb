require 'active_support/dependencies'

module LetsEncryptHeroku

  class ChallengeEngine < Rails::ChallengeEngine

    initialize "lets_encrypt_heroku.load_app_instance_data" do |app|
      LetsEncryptHeroku.configuration.app_root = app.root
    end

    initialize "lets_encrypt_heroku.load_static_assets" do |app|
      app.middleware.use ::ActionDispatch::Static, "#{app.root}/public"
    end

  end

end
