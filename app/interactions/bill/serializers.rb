module Bill::Serializers
  include User::Serializers

  BILL_ATTRIBUTES = %i(
    bill_type
    status
    payment_status
    payed_amount
    payed_date
  )

  def serialize_bill bill
    bill_json = BILL_ATTRIBUTES.inject({}){ |a,m| a.update m => bill.send(m) }
    bill_json.merge bill_user_info(bill)
  end


  def bill_user_info bill
    case bill.bill_type
      when 'parking_ticket'
        serialize_user_driver_license_info bill.user
      else
        serialize_user bill.user
    end
  end

 def serialize_bill_for_dashboard bill
    serialize_bill(bill).slice :bill_type, :payed_date
 end
end
