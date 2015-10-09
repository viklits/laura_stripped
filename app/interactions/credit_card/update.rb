class CreditCard::Update < CreditCard::Interaction

  def exec
    check_credit_card!
    @credit_card.update @args.except(:id)
    unless @credit_card.valid?
      raise InteractionErrors::ActiveModelError.new @credit_card.errors
    end
  end

end
