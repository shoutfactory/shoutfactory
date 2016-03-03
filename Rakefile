require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new :features

task :default => [:features]

task :run_tests do
  exec("bundle exec cucumber features/home_page.feature ;; esac")
end
