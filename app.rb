# encoding: utf-8

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

require_relative 'rules/initializer'
require_relative 'validator'
require_relative 'serializer'

require 'sinatra/cross_origin'

class BankSlipValidator < Sinatra::Base
  configure do
    enable :cross_origin
  end

  before do
    response.headers['Access-Control-Allow-Origin'] = '*'
  end

  post '/validate' do
    bank_slip = params[:file][:tempfile].readlines

    book = BookOfRules.new
    header_rules = book.list_header_rules
    body_rules = book.list_body_rules
    footer_rules = book.list_footer_rules

    validator = Validator.new
    header_validations = validator.validate_header(bank_slip: bank_slip[0], rules: header_rules)
    body_validations = validator.validate_body(bank_slip: bank_slip[1], rules: body_rules)
    body_annotations = validator.body_annotations
    footer_validations = validator.validate_footer(bank_slip: bank_slip[2], rules: footer_rules)

    serializer = Serializer.new
    serializer = serializer.serialize(header_validations, body_validations, body_annotations, footer_validations)
    
    return serializer
  end

  error 500 do
    erb :"500.html"
  end
end