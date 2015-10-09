class CreditCard::Create < CreditCard::Interaction
  def exec
    @credit_card = @current_user.credit_cards.create @args
    unless @credit_card.valid?
      raise InteractionErrors::ActiveModelError.new @credit_card.errors
    end
  end
end
