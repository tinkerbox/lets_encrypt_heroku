# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lets_encrypt_heroku/version'

Gem::Specification.new do |spec|
  spec.name = 'lets_encrypt_heroku'
  spec.version = LetsEncryptHeroku::VERSION

  spec.summary = ''
  spec.description = ''

  spec.authors = ['Jaryl Sim']
  spec.email = ['jaryl@tinkerbox.com.sg']

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  # spec.require_paths = ["lib", "app"]

  spec.homepage = ''
  spec.license = 'MIT'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "dotenv"
  spec.add_development_dependency "webmock"

  spec.add_dependency "platform-api"
  spec.add_dependency "acme-client"
  spec.add_dependency "activesupport"
  spec.add_dependency "rails"
end
