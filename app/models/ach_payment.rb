class AchPayment < ActiveRecord::Base

  validates :routing_nr, :first_name, :last_name, :account_nr,
    length: { maximum: STRING_LENGTH }, presence: true
  validates :account_nr, credit_card_number: true

  belongs_to :user

  def ap_type
    CreditCardValidations::Detector.new(account_nr).brand
  end

end
