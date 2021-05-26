module Header
  class BankName
    attr_reader :error
  
    def initialize
      @error = ''
    end
  
    def validate(bank_slip)
      bank_name = bank_slip[79,15]
  
      if bank_name.strip.upcase.eql?("BRADESCO")
        return true
      else
        @error = "Da coluna 080 a 094 deve estar escrito BRADESCO alinhado a esquerda com espaços em branco no lado direito para completar as 15 colunas."
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
      first_blank_space = bank_slip[100,8]
      second_blank_space = bank_slip[117,277]
  
      if first_blank_space.strip.empty? && second_blank_space.strip.empty?
        return true
      else
        @error = "Da coluna 101 a 108 e da coluna 118 a 394 devem ser espaços em branco! Por favor verifique novamente."
        return false
      end
    end
  end

  class BradescoNumber
    attr_reader :error

    def initialize
      @error = ''
    end

    def validate(bank_slip)
      bradesco_number = bank_slip[76,3]

      if bradesco_number.to_i.eql?(237)
        return true
      else
        @error = "Número do Bradesco na Câmara de Compensação deve ser obrigatoriamente 237 e deve ser da coluna 077 a 079."
        return false
      end
    end
  end

  class CompanyCode
    attr_reader :error
  
    def initialize
      @error = ''
    end
  
    def validate(bank_slip)
      company_code = bank_slip[26,19]

      if is_only_numbers?(company_code)
        return true
      else
        @error = "O código da empresa deve ser obrigatoriamente números inteiros e deve possuir tamanho 20. Ou seja, deve ser da coluna 027 a 046."
        return false
      end
    end
  
    private
  
    def is_only_numbers?(string)
      string.scan(/^\d+$/).any?
    end
  end

  class CompanyName
    attr_reader :error
  
    def initialize
      @error = ''
    end
  
    def validate(bank_slip)
      company_name = bank_slip[46,30]
  
      if !company_name.strip.empty?
        return true
      else
        @error = "A razão social da empresa não pode ficar em branco e deve possuir no máximo 30 caracteres, ou seja, deve ser da coluna 047 a 076."
        return false
      end
    end
  end

  class FileDate
    attr_reader :error
  
    def initialize
      @error = ''
    end
  
    def validate(bank_slip)
      file_date = "20#{bank_slip[98,2]}-#{bank_slip[96,2]}-#{bank_slip[94,2]}".to_date
  
      if !file_date.past?
        return true
      else
        @error = "A data colocada da coluna 095 a 100 está no passado, a data somente pode ser no presente ou no futuro."
        return false
      end
    end
  end

  class LiterallyRemittance
    attr_reader :error
  
    def initialize
      @error = ''
    end
  
    def validate(bank_slip)
      literally_remittance = bank_slip[2,7]
  
      if literally_remittance.eql?("REMESSA")
        return true
      else
        @error = "Da coluna 003 a coluna 009 deve estar obrigatoriamente escrito REMESSA."
        return false
      end
    end
  end

  class ServiceType
    attr_reader :error
  
    def initialize
      @error = ''
    end
  
    def validate(bank_slip)
      literally_service = bank_slip[11,15]
  
      if literally_service.strip.eql?("COBRANCA")
        return true
      else
        @error = "Da coluna 012 a coluna 026 deve estar obrigatoriamente escrito COBRANCA alinhado a esquerda com espaços em branco a direita para completar o tamanho de campo 15."
        return false
      end
    end
  end

  class RegisterIdentification
    attr_reader :error
    def initialize
      @error = ''
    end
  
    def validate(bank_slip)
      register_id = bank_slip[0]
  
      if register_id.to_i.eql?(0)
        return true
      else
        @error = 'Identificação do registro, coluna 001, deve ser obrigatoriamente 0.'
        return false
      end
    end
  end

  class RemittanceIdentification
    attr_reader :error
  
    def initialize
      @error = ''
    end
  
    def validate(bank_slip)
      remittance_id = bank_slip[1]
  
      if remittance_id.to_i.eql?(1)
        return true
      else
        @error = 'Identificação do arquivo de remessa, coluna 002, deve ser obrigatoriamente 1.'
      end
    end
  end

  class RemittanceSequentialNumber
    attr_reader :error
  
    def initialize
      @error = ''
    end
  
    def validate(bank_slip)
      remittance_number = bank_slip[110,7]
      
      if is_only_numbers?(remittance_number)
        return true
      else
        @error = "O código da empresa deve ser obrigatoriamente números inteiros e deve possuir tamanho 7. Ou seja, deve ser da coluna 111 a 117."
        return false
      end
    end
  
    private
  
    def is_only_numbers?(string)
      string.scan(/^\d+$/).any?
    end
  end

  class SequentialRegisterNumber
    attr_reader :error
    def initialize
      @error = ''
    end
  
    def validate(bank_slip)
      sequential_number = bank_slip[394,6]
  
      if sequential_number.to_i.eql?(000001)
        return true
      else
        @error = "O número sequencial do registro deve ser obrigatoriamente 000001"
        return false
      end
    end
  end

  class ServiceCode
    attr_reader :error
  
    def initialize
      @error = ''
    end
  
    def validate(bank_slip)
      service_code = bank_slip[9,2]
  
      if service_code.to_i.eql?(01)
        return true
      else
        @error = 'Código de serviço deve ser obrigatoriamente 01.'
      end
    end
  end

  class SystemIdentification
    attr_reader :error
    def initialize
      @error = ''
    end
  
    def validate(bank_slip)
      identificator = bank_slip[108,2]
  
      if identificator.eql?("MX")
        return true
      else
        @error = "O campo de identificaçáo do sistema, coluna 109 até 110, deve ser obrigatoriamente 'MX'"
        return false
      end
    end
  end
end