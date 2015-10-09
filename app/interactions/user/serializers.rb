module User::Serializers

  USER_ATTRIBUTES = %i{
    user_id
    first_name
    middle_name
    last_name
    email
    phone
    license_plate_number
    license_plate_state
    driver_license
    driver_license_state
    state
    address
  }

  def serialize_user user
    USER_ATTRIBUTES.inject({}){ |a,m| a.update m => user.send(m) }
  end

  def serialize_user_driver_license_info user
    serialize_user(user).slice :first_name, :middle_name, :last_name, :address,
      :driver_license, :license_plate_number
  end

  def serialize_user_general_info user
    serialize_user(user).slice :first_name, :middle_name, :last_name, :address
  end


end
