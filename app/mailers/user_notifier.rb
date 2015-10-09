class UserNotifier < ApplicationMailer
  default from: "Laura API <laura-no-reply@yandex.ru>"

  def password_recovery user, token
    @user = user
    @password_recovery_token = token.token
    mail(to: @user.email, subject: 'Password recovery instructions')
  end

  def profile_updated  user
    @user = user
    mail(to: @user.email, subject: 'Profile has been successfully updates')
  end

  def register_new_user  user
    @user = user
    mail(to: @user.email, subject: 'Register a new user')
  end
end
