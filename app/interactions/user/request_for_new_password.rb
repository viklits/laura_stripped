class User::RequestForNewPassword < InteractionBase
  include User::Serializers

  def exec
    @current_user = User.find_by email: @args[:email]
    raise InteractionErrors::InvalidUserError unless @current_user

    @password_recovery_token = @current_user.new_password_recovery_token
    UserNotifier.password_recovery(@current_user, @password_recovery_token).deliver_now
  end

  def as_json(opts = {})
    { message:  I18n.t('user.notifications.password.instructions_sent')}
  end
end
