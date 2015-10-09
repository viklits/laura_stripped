class Dashboard::Dashboard < InteractionBase

  include Dashboard::Serializers
  attr_accessor :dashboard

  def exec
    true
  end

  def as_json opts = {}
    serialize_dashboard @dashboard
  end
end
