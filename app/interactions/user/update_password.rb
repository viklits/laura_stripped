class User::UpdatePassword 
  attr_accessor :current_user, :args

  def initialize current_user:, args:
    @current_user = current_user
    @args         = args
  end

  def exec
    @current_user.update @args
    raise InteractionErrors::ActiveModelError.new current_user.errors unless current_user.valid?
    @current_user.password_recovery_tokens.destroy_all
  end

end
