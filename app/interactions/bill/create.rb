class Bill::Create < Bill::Interaction
  def exec
    @bill = @current_user.bills.create @args
    raise InteractionErrors::ActiveModelError.new(@bill.errors) unless @bill.valid?
  end
end
