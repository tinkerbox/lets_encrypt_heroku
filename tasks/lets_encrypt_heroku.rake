require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

namespace :testing do
  desc "This task is called by a scheduler to send daily leave report to management"
  task :run do
    puts "Running"
  end
end
