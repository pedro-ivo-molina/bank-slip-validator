class ValidationController < Sinatra::Base
  def validate!(bank_slip: bank_slip)
    rules = BookOfRules.new.list_of_rules
    
    validator = Validator.new

    validations = validator.validate!(bank_slip: bank_slip, rules: rules)

    return validations
  end
end