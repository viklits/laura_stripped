module AchPayment::Serializers
  ACH_PAYMENT_ATTRIBUTES = %i(
    routing_nr
    account_nr
    first_name
    middle_name
    last_name
  )

  def serialize_ach_payment ach_payment
    ACH_PAYMENT_ATTRIBUTES.inject({}){ |a,m| a.update m => ach_payment.send(m) }
  end

  def serialize_ach_payment_as_list_item ach_payment
    {
      last_digits: ach_payment.account_nr.split('').last(3).join,
      default_photo: ach_payment.ap_type,
      id: ach_payment.id
    }
  end
end
