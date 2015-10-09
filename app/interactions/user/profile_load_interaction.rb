class User::ProfileLoadInteraction < InteractionBase
  include User::Serializers

  def exec
    require_current_user!
  end

  def as_json(opts = {})
    serialize_user current_user
  end
end
