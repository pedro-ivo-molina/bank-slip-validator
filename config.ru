require 'rubygems'

require 'sinatra/base'
require 'bugsnag'
require 'active_support/json'
require 'active_support/core_ext/hash/indifferent_access'
require 'json'
require 'rack/ssl'
require 'open-uri'
require 'nokogiri'
require 'sinatra/strong-params'

# init dotenv
if ENV['RACK_ENV'] == 'development'
  require 'pry-byebug'
  require 'dotenv'
  Dotenv.load
end

# Bugsnag initialization
Bugsnag.configure do |configuration|
  configuration.project_root = Dir.pwd
  configuration.api_key = ENV["BUGSNAG_KEY"]
  configuration.release_stage = 'production'
end

register Sinatra::StrongParams

require './app'

run BankSlipValidator