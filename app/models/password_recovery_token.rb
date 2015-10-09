class PasswordRecoveryToken < ActiveRecord::Base
  belongs_to :user
  before_save ->(rec){ rec.token ||= Authentication::Token.new.generate}

  def password_errors field = :password
    return unless self.user.errors.any?
    self.user.errors.messages[field]
  end
end
