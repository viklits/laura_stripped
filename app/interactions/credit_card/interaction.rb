class CreditCard::Interaction < InteractionBase

  include CreditCard::Serializers
  attr_accessor :credit_card

  def as_json opts = {}
    serialize_credit_card @credit_card
  end

  def check_credit_card!
    @credit_card = @current_user.credit_cards.find_by id: @args[:id]
    raise InteractionErrors::CreditCardNotFound unless @credit_card
  end

end
