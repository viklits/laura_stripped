class User::UpdateProfileInteraction < InteractionBase
  include User::Serializers

  def exec
    require_current_user!
    current_user.update @args
    raise InteractionErrors::ActiveModelError.new current_user.errors unless current_user.valid?
    UserNotifier.profile_updated(current_user).deliver_now
  end

  def as_json(opts = {})
    serialize_user current_user
  end
end
