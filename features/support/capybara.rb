# frozen_string_literal: true

# defines capybara configuration

require "#{File.dirname(__FILE__)}/extensions.rb"
require 'capybara/poltergeist'

@driver = ENV['driver']

# Sets default driver to poltergeist
if @driver.nil?
  @driver = 'poltergeist'
elsif @driver == 'cuke' || @driver == 'p'
  @driver = 'poltergeist'
end

# sets test target to staging if no target= is not declared at runtime.
# Targets can be found in env_data.yml
if ENV['target'].nil?
  puts 'target= not defined, defaulting to staging.'.color(33)
  ENV['target'] = 'staging'
end

# setting configuration options.
target_config = File.expand_path(File.dirname(__FILE__) + '/env_data.yml')
polt_config = YAML.load(File.open(target_config))
target = polt_config[:target]
application_server = target[ENV['target'].to_sym]
host_url = "#{application_server[:host]}.website.com:#{application_server[:port]}"

# set capybara defaults to use poltergeist
Capybara.javascript_driver = :poltergeist
Capybara.default_driver = :poltergeist
# Capybara.run_server = false

Capybara.default_selector = :css

# sets the default wait time for generating a failure to 10 seconds.
Capybara.default_max_wait_time = 10 # seconds

# Set url that will be used in tests. Uses :host values from env.rb
Capybara.app_host = host_url
Capybara.default_host = Capybara.app_host

# sets phantomjs options and controls output to console. Ignore the error for
# Capybara::Poltergeist::Driver.new. It is invalid.
Capybara.register_driver :poltergeist do |app|
  options = {
    inspector: true,
    window_size: [1366, 768],
    phantomjs_logger: STDERR,
    js_errors: false,
    timeout: 600,
    phantomjs_options: [
      '--debug=false',
      '--load-images=yes',
      '--ignore-ssl-errors=yes',
      '--ssl-protocol=any'
    ],
    debug: false
  }
  Capybara::Poltergeist::Driver.new(app, options)
end

Capybara.configure do |config|
  config.match = :one
  config.exact_options = true
end

Capybara::Session.class_eval do
  def find_first_link(name)
    found = all('a').detect { |a|
      a.text.strip == name.strip
    }
    unless found
      found = all('a').detect { |a|
        a.text.strip =~ /^#{Regexp.escape(name.strip)}/ ||
          a.text.strip =~ /#{Regexp.escape(name.strip)}/
      }
    end
    found
  end
end
