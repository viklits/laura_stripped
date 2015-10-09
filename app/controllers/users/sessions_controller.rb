class Users::SessionsController < ApplicationController

  skip_before_action :authenticate!, only: [ :create ]

  # @description User sign in. User can be signed in via email or phone
  # @param auth_credentials[email] required String User's email
  # @param auth_credentials[phone] required String User's phone
  # @param auth_credentials[password] required String User's password
  def create
    auth_params = params.require(:auth_credentials).
      permit :email, :password, :phone
    respond_with_interaction User::SignInInteraction, auth_params

  rescue InteractionErrors::InvalidUserError
    respond_with_error I18n.t('user.errors.invalid_credentials'), 403
  rescue InteractionErrors::InvalidCredentialsError
    respond_with_error I18n.t('user.errors.invalid_credentials'), 403
  end

  # @descriptio User sign out
  def destroy
    respond_with_interaction User::SignOutInteraction, params

  rescue InteractionErrors::InvalidUserError
    respond_with_error I18n.t('user.errors.invalid_user'), 403
  end

  # @description User's profile
  def profile
    respond_with_interaction User::ProfileLoadInteraction, params
  rescue InteractionErrors::InvalidUserError
    respond_with_error I18n.t('user.errors.invalid_user'), 403
  end
end
