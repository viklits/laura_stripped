class Users::PasswordsController < ApplicationController

  skip_before_action :authenticate!, only: [:new, :edit, :update]
  skip_before_action :validate_headers!, only: [:edit, :update]
  before_action      :validate_token!, only: [:edit, :update]

  # @description serves a password recovery request
  # @param email required String User's email
  def new
    respond_with_interaction User::RequestForNewPassword, params
  rescue InteractionErrors::InvalidUserError => e
    respond_with_error I18n.t('user.errors.user_not_found'), 404
  end

  # @description password recovery form
  # @param token required String Unique password token
  def edit
  end


  # @description updates user's password according to given in params
  # @param user[password] required String User's password
  # @param user[password_confirmation] required String User's password confirmation
  # @param token required String password recovery token 
  def update
    password_params = params.require(:user).
      permit(:password, :password_confirmation)
    User::UpdatePassword.new(current_user: @token.user, args: password_params).exec

  rescue InteractionErrors::ActiveModelError => e
    render :edit
  end


  private

  def validate_token!
    @token = PasswordRecoveryToken.find_by token: params[:token]
    unless @token
      respond_with_error I18n.t('user.errors.invalid_password_recovery_token')
    end
  end
end
