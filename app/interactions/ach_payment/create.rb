class AchPayment::Create < AchPayment::Interaction
  def exec
    @ach_payment = @current_user.ach_payments.create @args
    unless @ach_payment.valid?
      raise InteractionErrors::ActiveModelError.new @ach_payment.errors
    end
  end
end
