class Validator
  def initialize
    @validation_errors = []
  end

  def validate!(bank_slip:, rules:)
    rules.each do |rule|
      rule.validate!(bank_slip: bank_slip)

      @validation_errors << rule.error
    end

    return @validation_errors
  end
end