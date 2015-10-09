module CreditCard::Serializers

  CREDIT_CARD_ATTRIBUTES = %i{
    id
    cc_number
    month
    year
    cvv
    zipcode
    card_holder_name
  }

  def serialize_credit_card credit_card
    CREDIT_CARD_ATTRIBUTES.inject({}){ |a,m| a.update m => credit_card.send(m) }
  end

  def serialize_credit_card_as_list_item credit_card
    {
      last_digits: credit_card.cc_number.to_s.split('').last(4).join,
      default_photo: credit_card.cc_type,
      id: credit_card.id
    }
  end
end
