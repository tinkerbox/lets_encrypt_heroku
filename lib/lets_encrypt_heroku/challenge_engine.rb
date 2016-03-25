require 'rails'

module LetsEncryptHeroku
  class ChallengeEngine < ::Rails::Engine
    isolate_namespace LetsEncryptHeroku
  end
end
