class CreditCard::Destroy < CreditCard::Interaction

  def exec
    check_credit_card!
    @credit_card.destroy
    unless @credit_card.destroyed?
      raise InteractionErrors::ActiveModelError.new @credit_card.errors
    end
  end


  def as_json opts = {}
    { message: I18n.t('credit_card.notifications.destroyed') }
  end
end
