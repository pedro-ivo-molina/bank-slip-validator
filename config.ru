require 'rubygems'

require 'sinatra'
require 'active_support/all'
require 'json'
require 'rack/ssl'
require 'open-uri'
require 'nokogiri'
require 'shotgun'
require 'puma'
require 'rspec'
require 'pry-byebug'

require './app'

run BankSlipValidator