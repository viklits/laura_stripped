class Bill < ActiveRecord::Base

  STATUSES = %w(payed unpayed)
  PAYMENT_STATUSES = %w(payed overdue due_soon due_later)
  BILL_TYPES = %w(parking_ticket water_bill vehicle_ticket)

  validates_inclusion_of :payment_status, in: PAYMENT_STATUSES
  validates_inclusion_of :status, in: STATUSES
  validates_inclusion_of :bill_type, in: BILL_TYPES

  validates_presence_of :bill_type, :status, :payment_status, :payed_amount, :payed_date
  validates :bill_type, :status, :payment_status,  length: { maximum: STRING_LENGTH }
  validates_numericality_of :payed_amount

  belongs_to :user

  scope :due_soon, -> { where payment_status: :due_soon }
end
