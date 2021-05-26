module Footer
  class RegisterIdentification
    attr_reader :error
    def initialize
      @error = ''
    end
  
    def validate(bank_slip)
      register_id = bank_slip[0]
  
      if register_id.to_i.eql?(9)
        return true
      else
        @error = 'Identificação do registro, coluna 001 da linha 03, deve ser obrigatoriamente 9.'
        return false
      end
    end
  end

  class BlankSpace
    attr_reader :error
  
    def initialize
      @error = ''
    end
  
    def validate(bank_slip)
      blank_space = bank_slip[1,393]
  
      if blank_space.strip.empty?
        return true
      else
        @error = "Da coluna 2 a 394 devem ser espaços em branco! Por favor verifique novamente."
        return false
      end
    end
  end

  class SequentialRegisterNumber
    attr_reader :error
    def initialize
      @error = ''
    end
  
    def validate(bank_slip)
      sequential_number = bank_slip[394,6]
  
      if sequential_number.to_i.eql?(000003)
        return true
      else
        @error = "O número sequencial do registro deve ser obrigatoriamente 000003"
        return false
      end
    end
  end
end