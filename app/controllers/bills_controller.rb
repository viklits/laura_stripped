class BillsController < ApplicationController

  # @description Creates new Bill
  # @param bill[bill_type] required String Can be one of:
  # parking_ticket, water_bill, vehicle_ticket
  # @param bill[status] required String Can be one of:
  # paid, unpayed
  # @param bill[payment_status] required String Can be one of:
  # payed, overdue, due_soon, due_later
  # @param bill[payed_amount] required String Payed amount of money
  # @param bill[payed_date] required Date Payed date in format: 2015-12-20
  def create
    respond_with_interaction Bill::Create, bill_params
  rescue InteractionErrors::ActiveModelError => e
    respond_with_error e.message
  end


  # @description Returns list of bills
  # @param bill_type  String Can be one of:
  # parking_ticket, water_bill, vehicle_ticket
  # @param status  String Can be one of:
  # paid, unpayed
  # @param payment_status  String Can be one of:
  # payed, overdue, due_soon, due_later
  def index
    respond_with_interaction Bill::Index, params
  end

  private

  def bill_params
    params.require(:bill).
      permit :bill_type, :status, :payment_status, :payed_amount, :payed_date
  end
end
