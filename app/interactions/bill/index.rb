class Bill::Index < InteractionBase
  include Bill::Serializers

  def exec
    @bills = @current_user.bills.where(conditions).map { |bill| serialize_bill bill }
  end

  def as_json opts = {}
    @bills
  end

  def conditions
    @args.slice(:status, :payment_status, :bill_type).keep_if{|k,v| v}.to_hash
  end
end
