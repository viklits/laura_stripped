module LauraSpecHelper

  def LauraSpecHelper.another_valid_user_params
    {
      email:                  'user1@gmail.com',
      user_id:                'user1@gmail.com',
      password:               '123uu123',
      password_confirmation:  '123uu123'
    }
  end

  def LauraSpecHelper.valid_user_params
    {
      email:                  'user@gmail.com',
      user_id:                'user@gmail.com',
      password:               '123uu123',
      password_confirmation:  '123uu123'
    }
  end

  def LauraSpecHelper.android_device
    {
      'HTTP_X_DEVICE_ID'           => '222222',
      'HTTP_X_MOBILE_PLATFORM'     => 'Android',
      'HTTP_X_APPLICATION_NAME'    => 'Laura Android App',
      'HTTP_X_APPLICATION_VERSION' => '1',
      'HTTP_X_DEVICE_TIME_ZONE'    => '+1',
      'HTTP_X_DEVICE_LOCALE'       => 'en-us',
      'HTTP_X_PUSH_NOTIFICATION_TOKEN' => '999999'
    }
  end

  def LauraSpecHelper.ios_device
    {
      'X-DEVICE-ID'           => '1111111',
      'X-MOBILE-PLATFORM'     => 'IOS',
      'X-APPLICATION-NAME'    => 'Laura IOS App',
      'HTTP_X_PUSH_NOTIFICATION_TOKEN' => '88888888',
      'X-APPLICATION-VERSION' => '1',
      'X-DEVICE-TIME-ZONE'    => '+1',
      'X-DEVICE-LOCALE'       => 'en-us',
    }
  end

  def LauraSpecHelper.valid_user_profile
    {
      user: {
        first_name:           'John',
        middle_name:          'Simon',
        last_name:            'Smith',
        license_plate_number: '1'*10,
        license_plate_state:  'active',
        driver_license:       'some_driver_license_id',
        driver_license_state: 'driver_license_state_id',
        state:                'Washington',
        address:              'somewhere str, 1',
      }
    }
  end

end
