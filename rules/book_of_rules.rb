require_relative 'header_rules'
require_relative 'body_rules'
require_relative 'footer_rules'

class BookOfRules
  def list_header_rules
    header_rules = []

    header_rules << Header::BankName.new
    header_rules << Header::BlankSpace.new
    header_rules << Header::BradescoNumber.new
    header_rules << Header::CompanyCode.new
    header_rules << Header::CompanyName.new
    header_rules << Header::FileDate.new
    header_rules << Header::LiterallyRemittance.new
    header_rules << Header::ServiceType.new
    header_rules << Header::RegisterIdentification.new
    header_rules << Header::RemittanceIdentification.new
    header_rules << Header::RemittanceSequentialNumber.new
    header_rules << Header::SequentialRegisterNumber.new
    header_rules << Header::ServiceCode.new
    header_rules << Header::SystemIdentification.new

    return header_rules
  end

  def list_body_rules
    body_rules = []

    body_rules << Body::AddressingForDebt.new
    body_rules << Body::AllowanceValue.new
    body_rules << Body::ApportionmentIndicatior.new
    body_rules << Body::AutomaticDebitIdentification.new
    body_rules << Body::BankDigit.new
    body_rules << Body::BankTitleIdentification.new
    body_rules << Body::BlankSpace.new
    body_rules << Body::BonusPerDay.new
    body_rules << Body::BradescoNumber.new
    body_rules << Body::Cep.new
    body_rules << Body::CollectionNote.new
    body_rules << Body::Date.new
    body_rules << Body::DelayDay.new
    body_rules << Body::DiscountAmount.new
    body_rules << Body::DocumentNumber.new
    body_rules << Body::FinePercentage.new
    body_rules << Body::Fine.new
    body_rules << Body::Instructions.new
    body_rules << Body::Iof.new
    body_rules << Body::OccurrenceIdentification.new
    body_rules << Body::PayerAddress.new
    body_rules << Body::PayerDocumentType.new
    body_rules << Body::PayerName.new
    body_rules << Body::PayerRegistrationNumber.new
    body_rules << Body::RegisterIdentification.new
    body_rules << Body::SequentialRegisterNumber.new
    body_rules << Body::TitleKind.new
    body_rules << Body::TitleValue.new
    body_rules << Body::WalletIdentification.new
    body_rules << Body::Zeros.new

    return body_rules
  end

  def list_footer_rules
    footer_rules = []
    
    footer_rules << Footer::RegisterIdentification.new
    footer_rules << Footer::BlankSpace.new
    footer_rules << Footer::SequentialRegisterNumber.new

    return footer_rules
  end
end