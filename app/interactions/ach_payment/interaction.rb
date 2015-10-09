class AchPayment::Interaction < InteractionBase
  include AchPayment::Serializers

  attr_accessor :ach_payment

  def as_json opts = {}
    serialize_ach_payment(@ach_payment)
  end


  def check_ach_payment!
    @ach_payment = @current_user.ach_payments.find_by id: @args[:id]
    raise InteractionErrors::AchPaymentNotFound unless @ach_payment
  end
end
