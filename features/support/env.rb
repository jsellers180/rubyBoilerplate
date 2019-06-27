# frozen_string_literal: true

# Requires gems for files in the suite

require 'rubygems'
require 'pry'
require 'cucumber/formatter/unicode'
require 'capybara/cucumber'
require 'rspec/expectations'
require 'test/unit/assertions'
require 'cgi'
require 'gmail'
require 'active_support/core_ext/object/blank'
require 'net/http'
require 'uri'
require 'json'
require 'luhnacy'
require 'rest-client'
require_relative './clients/user_client'
require_relative './clients/cc_client'

# SERVICES = YAML.load_file(File.dirname(__FILE__) + '/services_config.yml')

World(Test::Unit::Assertions)
