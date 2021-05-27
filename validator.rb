class Validator
  attr_reader :body_annotations

  def initialize
    @header_errors = []
    @body_errors = []
    @body_annotations = []
    @footer_errors = []
  end

  def validate_header(bank_slip:, rules:)
    rules.each do |rule|
      rule.validate(bank_slip)

      @header_errors << rule.error unless rule.error.empty?
    end

    return @header_errors
  end

  def validate_body(bank_slip:, rules:)
    rules.each do |rule|
      rule.validate(bank_slip)

      @body_errors << rule.error unless rule.error.empty?      
      @body_annotations << rule.annotation unless rule.annotation.empty?
    end

    return @body_errors
  end

  def validate_footer(bank_slip:, rules:)
    rules.each do |rule|
      rule.validate(bank_slip)

      @footer_errors << rule.error unless rule.error.empty?
    end

    return @footer_errors
  end
end