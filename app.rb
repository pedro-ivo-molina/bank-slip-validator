# encoding: utf-8

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

class BankSlipValidator < Sinatra::Base

  get '/' do
    halt 200
  end

  post '/validate', needs: [:file] do
    bank_slip = params[:file]

    validations = ValidationController.new.validate!(bank_slip: bank_slip)

    content_type :json
    { validations: validations }.to_json
  end

  error 500 do
    erb :"500.html"
  end
end