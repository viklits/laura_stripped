module InteractionErrors
  InvalidUserError = Class.new(StandardError)
  InvalidCredentialsError = Class.new(StandardError)

  InvalidBillParamsError = Class.new(StandardError)

  AchPaymentNotFound = Class.new(StandardError)
  CreditCardNotFound = Class.new(StandardError)


  class ActiveModelError < StandardError
    def initialize active_model_errors = nil
      @active_model_errors = active_model_errors
    end

    def errors
      @active_model_errors
    end

    def message
      @active_model_errors.full_messages.join("\n") if @active_model_errors
    end
  end
end
