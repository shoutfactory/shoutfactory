$: << File.dirname(__FILE__)+'/../lib'

ENVIRONMENT = (ENV['ENVIRONMENT'] || 'production').to_sym
Dir::mkdir('report') unless File.directory?('report')
raise "You need to create a configuration file named '#{ENVIRONMENT}.yml' under lib/config" unless File.exists? "#{File.dirname(__FILE__)}/../../lib/config/#{ENVIRONMENT}.yml"

require 'capybara'
require 'capybara/cucumber'
require 'capybara/dsl'
require 'selenium-webdriver'
require 'site_prism'
require 'rspec'
require 'faker'
require 'env_config'
require 'shoutfactory'
require 'pages'
require 'support/string'
require 'capybara_helper'
require 'active_support/inflector'
require 'net/http'

World(CapybaraHelper)

Capybara.configure do |config|
  config.default_driver = :selenium
  config.javascript_driver = :selenium

  config.run_server = EnvConfig.get :run_server
  config.default_selector = EnvConfig.get :default_selector
  config.default_wait_time = EnvConfig.get :wait_time

  #capybara 2.5.0 config options
  config.match = EnvConfig.get :match
  config.ignore_hidden_elements = EnvConfig.get :ignore_hidden_elements
end


Before do
  page.driver.browser.manage.timeouts.page_load = 300
  page.driver.browser.manage.delete_all_cookies
  page.driver.browser.manage.window.resize_to(1600, 1200) if Capybara.default_driver == :selenium
  @random_string = Faker::Lorem.characters(4)
end

After do |scenario|
  if scenario.failed?
    screenshot = "./report/FAILED_#{scenario.name.gsub(' ','_').gsub(/[^0-9A-Za-z_]/, '')}.png"
    begin
    page.driver.save_screenshot(screenshot)
    rescue Errno::ECONNREFUSED
      puts "no connection"
      Capybara.reset_sessions!
    end
    embed screenshot, 'image/png'
  end
end
