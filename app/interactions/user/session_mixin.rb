module User::SessionMixin

  def session_data
    @_session_data ||= {
      mobile_device_id => {
        platform:                 mobile_device_platform,
        app_name:                 mobile_app_name,
        push_notification_token:  mobile_push_notification_token
      }.update(current_authentication_token)
    }
  end

  def current_authentication_token
    @_auth_token ||= { authentication_token: Authentication::Token.new.generate }
  end
end
