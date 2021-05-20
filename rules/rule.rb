class Rule
  def validate!
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end
end