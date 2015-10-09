class CreditCard < ActiveRecord::Base
  belongs_to :user
  validates :cc_number, :month, :year, :cvv, :zipcode, presence: true,
    length: { maximum: STRING_LENGTH}
  validates :cc_number, credit_card_number: true


  def cc_type
    CreditCardValidations::Detector.new(cc_number).brand
  end

  def card_holder_name
    user.full_name
  end
end
