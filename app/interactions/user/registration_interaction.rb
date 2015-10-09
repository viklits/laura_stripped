class User::RegistrationInteraction < InteractionBase
  include User::Serializers
  include User::SessionMixin

  def exec
    args[:devices] = session_data
    @user = User.create args
    raise InteractionErrors::ActiveModelError.new @user.errors unless @user.valid?
    UserNotifier.register_new_user(@user).deliver_now
  end

  def as_json opts = {}
    serialize_user(@user).update current_authentication_token
  end
end
