module Body
  class AddressingForDebt
    attr_reader :error, :annotation
    
    def initialize
      @error = ''
      @annotation = ''
    end
  
    def validate(bank_slip)
      addressing = bank_slip[105]
  
      if !addressing.empty? && is_only_numbers?(addressing)
        @annotation = "Endereçamento para aviso de débito automático em conta corrente foi preenchido."
        return true
      else
        @annotation = "Endereçamento para aviso de débito automático em conta corrente não foi preenchido."
        return true
      end
    end
  
    private
  
    def is_only_numbers?(string)
      string.scan(/^\d+$/).any?
    end
  end

  class AllowanceValue
    attr_reader :error, :annotation
    
    def initialize
      @error = ''
      @annotation = ''
    end
  
    def validate(bank_slip)
      allowance_value = bank_slip[205,13]
  
      if is_only_numbers?(allowance_value)
        return true
      else
        @error = 'Valor de abatimento(coluna 206 até 218) deve ser somente números inteiros!'
        return false
      end
    end
  
    private
  
    def is_only_numbers?(string)
      string.scan(/^\d+$/).any?
    end
  end

  class ApportionmentIndicatior
    attr_reader :error, :annotation
    
    def initialize
      @error = ''
      @annotation = ''
    end
  
    def validate(bank_slip)
      apportionment = bank_slip[104]
  
      if !apportionment.empty? && apportionment.eql?("R")
        @annotation = "Indicador de rateio de crédito foi preenchido."
        return true
      else
        @annotation = "Indicador de rateio de crédito não foi preenchido."
        return false
      end
    end
  end

  class AutomaticDebitIdentification
    attr_reader :error, :annotation
  
    def initialize
      @error = ''
      @annotation = ''
    end
  
    def validate(bank_slip)
      debit_id = bank_slip[93]
  
      if !debit_id.eql?("N")
        return true
      else
        @error = 'Identificador de emissão de boleto para débito automático preenchido com letra N, banco deve registrar e emitir boleto.'
        return false
      end
    end
  end

  class BankDigit
    attr_reader :error, :annotation
  
    def initialize
      @error = ''
      @annotation = ''
    end
  
    def validate(bank_slip)
      bank_digit = bank_slip[81]
  
      if !bank_digit.strip.empty?
        return true
      else
        @error = 'Digito de auto conferencia do número bancário não pode ficar em branco e deve preencher a coluna 082.'
        return false
      end
    end
  end

  class BankTitleIdentification
    attr_reader :error, :annotation
  
    def initialize
      @error = ''
      @annotation = ''
    end
  
    def validate(bank_slip)
      title = bank_slip[70,11]
  
      if is_only_numbers?(title)
        return true
      else
        @error = 'Identificação do título do Banco deve ser obrigatoriamente numeros inteiros e deve ser da coluna 071 até 081.'
        return false
      end
    end
  
    private
  
    def is_only_numbers?(string)
      string.scan(/^\d+$/).any?
    end
  end

  class BlankSpace
    attr_reader :error, :annotation
  
    def initialize
      @error = ''
      @annotation = ''
    end
  
    def validate(bank_slip)
      first_blank_space = bank_slip[94,10]
      second_blank_space = bank_slip[106,2]
  
      if first_blank_space.strip.empty? && second_blank_space.strip.empty?
        return true
      else
        @error = "Da coluna 95 a 104 e da coluna 107 a 108 devem ser espaços em branco! Por favor verifique novamente."
        return false
      end
    end
  end

  class BonusPerDay
    attr_reader :error, :annotation
  
    def initialize
      @error = ''
      @annotation = ''
    end
  
    def validate(bank_slip)
      bonus = bank_slip[82,10]
  
      if is_only_numbers?(bonus)
        return true
      else
        @error = 'Desconto da bonificação por dia deve ser somente numeros inteiros e deve preencher da coluna 083 a 092.'
        return false
      end
    end
  
    private
  
    def is_only_numbers?(string)
      string.scan(/^\d+$/).any?
    end
  end

  class BradescoNumber
    attr_reader :error, :annotation
  
    def initialize
      @error = ''
      @annotation = ''
    end
  
    def validate(bank_slip)
      bradesco_number = bank_slip[62,3]
  
      if bradesco_number.to_i.eql?(237)
        return true
      else
        @error = "Número do Bradesco na Câmara de Compensação deve ser obrigatoriamente 237 e deve ser da coluna 063 a 065."
        return false
      end
    end
  end

  class Cep
    attr_reader :error, :annotation
    def initialize
      @error = ''
      @annotation = ''
    end
  
    def validate(bank_slip)
      cep_prefix = bank_slip[326,5]
      cep_sufix = bank_slip[331,3]
  
      if is_only_numbers?(cep_prefix) && is_only_numbers?(cep_sufix)
        return true
      else
        @error = 'Prefixo e sufixo do cep devem ser somente números!'
        return false
      end
    end
  
    private
  
    def is_only_numbers?(string)
      string.scan(/^\d+$/).any?
    end
  end

  class CollectionNote
    attr_reader :error, :annotation
    
    def initialize
      @error = ''
      @annotation = ''
    end
  
    def validate(bank_slip)
      collection_condition = bank_slip[92]
  
      if collection_condition.to_i.eql?(1)
        @annotation = "Condição para emissão da papeleta de cobrança preenchida com 1. Banco deve emitir e processar o registro."
        return true
      elsif collection_condition.to_i.eql?(2)
        @annotation = "Condição para emissão da papeleta de cobrança preenchida com 2. Banco deve somente processar o registro."
        return true
      else
        @error = "Condição para emissão da papeleta deve ser obrigatoriamente 1 ou 2 e deve ser preenchida na coluna 093."
        return false
      end
    end
  end

  class Date
    attr_reader :error, :annotation
  
    def initialize
      @error = ''
      @annotation = ''
    end
  
    def validate(bank_slip)
      title_expire_date = "20#{bank_slip[124,2]}-#{bank_slip[122,2]}-#{bank_slip[120,2]}".to_date

      title_emission_date = "20#{bank_slip[154,2]}-#{bank_slip[152,2]}-#{bank_slip[150,2]}".to_date
  
      limit_date = "20#{bank_slip[177,2]}-#{bank_slip[175,2]}-#{bank_slip[173,2]}".to_date
  
      if !title_expire_date.past? && !title_emission_date.past?
        return true
      else
        @error = "Por favor verifique novamente as datas colocadas da coluna 121 até 125, da coluna 151 até 155 e 174 até 179!"
        return false
      end
    end
  end

  class DelayDay
    attr_reader :error, :annotation
    
    def initialize
      @error = ''
      @annotation = ''
    end
  
    def validate(bank_slip)
      delay_day = bank_slip[160,13]
  
      if is_only_numbers?(delay_day)
        return true
      else
        @error = 'Valor a ser cobrado por dia de atraso deve ser somente números inteiros e deve ser preenchido na coluna 161 até 173.'
        return false
      end
    end
  
    private
  
    def is_only_numbers?(string)
      string.scan(/^\d+$/).any?
    end
  end

  class DiscountAmount
    attr_reader :error, :annotation
    
    def initialize
      @error = ''
      @annotation = ''
    end
  
    def validate(bank_slip)
      discount_amount = bank_slip[179,13]
  
      if is_only_numbers?(discount_amount)
        return true
      else
        @error = 'Valor do desconto(coluna 180 até 192) deve ser somente números inteiros!'
        return false
      end
    end
  
    private
  
    def is_only_numbers?(string)
      string.scan(/^\d+$/).any?
    end
  end

  class DocumentNumber
    attr_reader :error, :annotation
    
    def initialize
      @error = ''
      @annotation = ''
    end
  
    def validate(bank_slip)
      document_number = bank_slip[110,10]
  
      if is_only_numbers?(document_number)
        return true
      else
        @error = 'Número do documento deve ser somente números inteiros e deve preencher da coluna 111 até 120.'
        return false
      end
    end
  
    private
  
    def is_only_numbers?(string)
      string.scan(/^\d+$/).any?
    end
  end

  class FinePercentage
    attr_reader :error, :annotation
  
    def initialize
      @error = ''
      @annotation = ''
    end
  
    def validate(bank_slip)
      fine_percentage = bank_slip[66,4]
  
      if is_only_numbers?(fine_percentage)
        @annotation = "Percentual de multa é: #{fine_percentage}"
        return true
      else
        @error = "Percentual de multa deve ser somente números e deve ser da coluna 067 até 070."
        return false
      end
    end
  
    private
  
    def is_only_numbers?(string)
      string.scan(/^\d+$/).any?
    end
  end

  class Fine
    attr_reader :error, :annotation
  
    def initialize
      @error = ''
      @annotation = ''
    end
  
    def validate(bank_slip)
      fine_option = bank_slip[65]
  
      if fine_option.to_i.eql?(2)
        @annotation = "Campo de percentual de multa preenchido com 2. Por favor considerar percentual de multa."
        return true
      elsif fine_option.to_i.eql?(0)
        @annotation = "Campo de percentual de multa preenchido com 0. Por favor não considerar percentual de multa."
        return true
      else
        @error = "Número do Bradesco na Câmara de Compensação deve ser obrigatoriamente 237 e deve ser da coluna 063 a 065."
        return false
      end
    end
  end

  class Instructions
    attr_reader :error, :annotation
    def initialize
      @error = ''
      @annotation = ''
    end
  
    def validate(bank_slip)
      first_instruction = bank_slip[156,2]
      second_instruction = bank_slip[158,2]
  
      if first_instruction.to_i.eql?(6) && is_only_numbers?(second_instruction)
        return true
      else
        @error = 'Primeira instrução(coluna 157/158) deve ser obrigatoriamente 6. Além disso a primeira e segunda instruções(coluna 159/160) devem ambas ser somente números inteiros, por favor verificar novamente.'
        return false
      end
    end
  
    private
  
    def is_only_numbers?(string)
      string.scan(/^\d+$/).any?
    end
  end

  class Iof
    attr_reader :error, :annotation
    
    def initialize
      @error = ''
      @annotation = ''
    end
  
    def validate(bank_slip)
      iof_value = bank_slip[192,13]
  
      if is_only_numbers?(iof_value)
        return true
      else
        @error = 'Valor do IOF(coluna 193 até 205) deve ser somente números inteiros!'
        return false
      end
    end
  
    private
  
    def is_only_numbers?(string)
      string.scan(/^\d+$/).any?
    end
  end

  class OccurrenceIdentification
    attr_reader :error, :annotation
    def initialize
      @error = ''
      @annotation = ''
    end
  
    def validate(bank_slip)
      occurrence = bank_slip[108,2]
  
      if is_only_numbers?(occurrence)
        return true
      else
        @error = 'Identificação da ocorrência deve ser somente números inteiros e deve preencher as colunas 109 e 110.'
        return false
      end
    end
  
    private
  
    def is_only_numbers?(string)
      string.scan(/^\d+$/).any?
    end
  end

  class PayerAddress
    attr_reader :error, :annotation
    
    def initialize
      @error = ''
      @annotation = ''
    end
  
    def validate(bank_slip)
      address = bank_slip[234,40]
  
      if !address.strip.empty?
        return true
      else
        @error = 'Endereço do pagador não pode ficar em branco!'
        return false
      end
    end
  end

  class PayerDocumentType
    attr_reader :error, :annotation
    
    def initialize
      @error = ''
      @annotation = ''
    end
  
    def validate(bank_slip)
      document_type = bank_slip[218,2]
  
      case document_type.to_i
      when 1
        @annotation = "CPF"
        return true
      when 2
        @annotation = "CNPJ"
        return true
      when 3
        @annotation = "PIS/PASEP"
        return true
      when 98
        @annotation = "Não tem tipo de documento do pagador."
        return true
      when 99
        @annotation = "Outros"
        return true
      else
        @error = "Não foi digitado um código de tipo de inscrição do pagador válido!"
        return false
      end
    end
  end

  class PayerName
    attr_reader :error, :annotation
    
    def initialize
      @error = ''
      @annotation = ''
    end
  
    def validate(bank_slip)
      name = bank_slip[234,40]
  
      if !name.strip.empty?
        return true
      else
        @error = 'Nome do pagador não pode ficar em branco!'
        return false
      end
    end
  end

  class PayerRegistrationNumber
    attr_reader :error, :annotation
    
    def initialize
      @error = ''
      @annotation = ''
    end
  
    def validate(bank_slip)
      registration_number = bank_slip[220,14]
  
      if is_only_numbers?(registration_number)
        return true
      else
        @error = 'Número de documento do pagador deve ser somente números inteiros, por favor verifique novamente!'
        return false
      end
    end
  
    private
  
    def is_only_numbers?(string)
      string.scan(/^\d+$/).any?
    end
  end

  class RegisterIdentification
    attr_reader :error, :annotation
  
    def initialize
      @error = ''
      @annotation = ''
    end

    def validate(bank_slip)
      register_id = bank_slip[0]
  
      if register_id.to_i.eql?(1)
        return true
      else
        @error = 'Identificação do registro, coluna 001 da linha 02, deve ser obrigatoriamente 1.'
        return false
      end
    end
  end

  class SequentialRegisterNumber
    attr_reader :error, :annotation
    
    def initialize
      @error = ''
      @annotation = ''
    end
  
    def validate(bank_slip)
      sequential_number = bank_slip[394,6]
  
      if sequential_number.to_i.eql?(000002)
        return true
      else
        @error = "O número sequencial do registro deve ser obrigatoriamente 000002."
        return false
      end
    end
  end

  class TitleKind
    attr_reader :error, :annotation
    
    def initialize
      @error = ''
      @annotation = ''
    end
  
    def validate(bank_slip)
      kind = bank_slip[147,2]
  
      if kind.to_i.eql?(01)
        return true
      else
        @error = 'Valor da espécie de título deve ser obrigatoriamente 01 e deve ser colocado na coluna 148 e 149 respectivamente.'
        return false
      end
    end
  end

  class TitleValue
    attr_reader :error, :annotation
    
    def initialize
      @error = ''
      @annotation = ''
    end
  
    def validate(bank_slip)
      value = bank_slip[126,13]
  
      if is_only_numbers?(value)
        return true
      else
        @error = 'Valor do título deve ser somente números inteiros e deve ir da coluna 127 até 139.'
        return false
      end
    end
  
    private
  
    def is_only_numbers?(string)
      string.scan(/^\d+$/).any?
    end
  end

  class WalletIdentification
    attr_reader :error, :annotation
  
    def initialize
      @error = ''
      @annotation = ''
    end
  
    def validate(bank_slip)
      wallet_id = bank_slip[21,3]
  
      if wallet_id.to_i.eql?(19)
        return true
      else
        @error = 'Identificação da carteira, coluna 023 e 024, deve ser obrigatoriamente 019.'
        return false
      end
    end
  end

  class Zeros
    attr_reader :error, :annotation
  
    def initialize
      @error = ''
      @annotation = ''
    end
  
    def validate(bank_slip)
      first_columns_with_zero = bank_slip[1,20]
      second_columns_with_zero = bank_slip[24,13]
      third_columns_with_zero = bank_slip[139,7]
  
      if first_columns_with_zero.to_i.eql?(0) && second_columns_with_zero.to_i.eql?(0) && third_columns_with_zero.to_i.eql?(0)
        return true
      else
        @error = 'Da coluna 002 até a coluna 021 e depois da coluna 25 até a 37 deve ser preenchida somente por zeros. O mesmo vale da coluna 140 até a 147. Por favor verifique se essas colunas estão somente com zeros.'
        return false
      end
    end
  end
end