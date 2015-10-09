class ApplicationController < ActionController::Base
  before_action :validate_headers!
  before_action :authenticate!

  def validate_headers!
    respond_with_error I18n.t('user.errors.invalid_headers') unless device_id
  end

  def authenticate!
    render text: '', status: 401 and return unless current_user
  end

  def device_id
    request.headers['HTTP_X_DEVICE_ID'] || request.headers['X-DEVICE-ID']
  end

  def token
    request.headers['X-AUTHENTICATION'].to_s.split('=').last.presence
  end

  def respond_with_interaction interaction_class, interaction_params
    interaction = interaction_class.new current_user: current_user,
      headers: request.headers, args: interaction_params
    interaction.exec
    render json: interaction
  end

  def respond_with_error message, code = 422
    render json: {error: message}, status: code
  end

  def current_user
    User.find_by_auth_token device_id, token if token
  end
  helper_method :current_user
end
