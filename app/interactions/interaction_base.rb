class InteractionBase
  include HeadersMixin
  include InteractionErrors
  attr_accessor :current_user, :headers, :args

  def initialize(current_user:, headers:, args:)
    @current_user = current_user
    @headers = headers
    @args = args
  end

  def exec
    # Should be overriden
  end

  def require_current_user!
    raise InvalidUserError.new unless current_user
  end
  protected :require_current_user!
end
