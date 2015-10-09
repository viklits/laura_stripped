class User::SignInInteraction < InteractionBase
  include User::Serializers
  include User::SessionMixin

  def exec
    the_id = @args[:email].presence || @args[:phone].presence
    @user = User.find_for_authentication the_id
    raise InteractionErrors::InvalidUserError.new unless @user
    raise InteractionErrors::InvalidCredentialsError.new unless @user.authenticate(args[:password])
    @user.add_auth_token session_data
  end

  def as_json opts = {}
    serialize_user(@user).update current_authentication_token
  end
end
