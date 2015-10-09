class Users::RegistrationsController < ApplicationController
  skip_before_action :authenticate!, only: [:create]

  # @description implements first registration step
  # @param user[user_id] required String Should be uniq
  # @param user[email] required String User's email
  # @param user[password] required String User's password, min length 8 chars
  # @param user[password_confirmation] required String User's password confirmation, min length 8 chars
  def create
    user_params = params.require(:user).permit(
      :user_id, :email, :password, :password_confirmation)
    respond_with_interaction User::RegistrationInteraction, user_params

  rescue InteractionErrors::ActiveModelError => e
    respond_with_error e.message
  end

  # @description implements second registration step
  # @param user[phone] String User's phone number
  # @param user[first_name] String User's first_name
  # @param user[middle_name] String User's middle name
  # @param user[last_name] String User's last name
  # @param user[license_plate_number] String User's license plate number
  # @param user[license_plate_state] String User's license plate state
  # @param user[driver_license] String User's driver license
  # @param user[driver_license_state] String User's driver license state
  # @param user[state] String User's state
  # @param user[address] String User's address
  def update
    user_params = params.require(:user).permit(
      :user_id, :email, :phone, :user_id, :first_name, :middle_name, :last_name,
      :email, :phone, :license_plate_number, :license_plate_state,
      :driver_license_state, :state, :address, :driver_license)

    respond_with_interaction User::UpdateProfileInteraction, user_params

  rescue InteractionErrors::ActiveModelError => e
    respond_with_error e.message
  rescue InteractionErrors::InvalidUserError
    respond_with_error I18n.t('user.errors.invalid_user'), 403
  end
end
