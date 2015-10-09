class Bill::Interaction < InteractionBase
  include Bill::Serializers

  attr_accessor :bill

  def as_json opts = {}
    serialize_bill(@bill)
  end

end
