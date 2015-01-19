ENV['RACK_ENV'] = 'test'

require_relative '../../web'

require 'capybara/cucumber'
require 'rspec'

require 'email_spec'
require 'email_spec/cucumber'

Capybara.app = TestWeb

World do
  TestWeb.new
end