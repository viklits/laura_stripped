class AchPayment::Destroy < AchPayment::Interaction

  def exec
    check_ach_payment!
    @ach_payment.destroy

    unless @ach_payment.destroyed?
      raise InteractionErrors::ActiveModelError.new @ach_payment.errors
    end
  end

  def as_json opts = {}
    { message: I18n.t('ach_payment.notifications.destroyed') }
  end
end
