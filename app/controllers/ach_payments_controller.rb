class AchPaymentsController < ApplicationController

  # @description Destroys existing ACH payment
  # @param id required Integer ACH payment id
  def destroy
    respond_with_interaction AchPayment::Destroy, params.slice(:id)

  rescue InteractionErrors::AchPaymentNotFound
    respond_with_error I18n.t('ach_payment.errors.not_found'), 404
  rescue InteractionErrors::ActiveModelError => e
    respond_with_error e.message
  end

  # @description Creates new ACH Payment
  # @param ach_payment[routing_nr] required String Routing nr
  # @param ach_payment[account_nr] required String Account nr
  # @param ach_payment[first_name] required String First name
  # @param ach_payment[middle_name] String Middle name
  # @param ach_payment[last_name] required String Last name
  def create
    respond_with_interaction AchPayment::Create, ach_payment_params
  rescue InteractionErrors::ActiveModelError => e
    respond_with_error e.message
  end


  # @description Returns list of payments
  def index
    respond_with_interaction AchPayment::Index, params
  end

  private

  def ach_payment_params
    params.require(:ach_payment).
      permit :routing_nr, :account_nr, :first_name, :middle_name, :last_name
  end
end
