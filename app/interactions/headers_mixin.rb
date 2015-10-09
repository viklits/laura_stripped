module HeadersMixin
  extend ActiveSupport::Concern

  # X-DEVICE-ID  :  abcd0123 // device unique identifier
  # X-MOBILE-PLATFORM  :  ios   // device platform name (ios, android)
  # X-APPLICATION-NAME :  Astro DJ // name of application
  # X-APPLICATION-VERSION  : 1.0.0  // version name of the application
  # X-DEVICE-TIME-ZONE
  # X-DEVICE-LOCALE

  attr_accessor :headers

  MOBILE_HEADERS_KEYS = %w(
    HTTP_X_DEVICE_ID
    HTTP_X_MOBILE_PLATFORM
    HTTP_X_APPLICATION_NAME
    HTTP_X_APPLICATION_VERSION
    HTTP_X_DEVICE_TIME_ZONE
    HTTP_X_DEVICE_LOCALE
    HTTP_X_PUSH_NOTIFICATION_TOKEN
    X-DEVICE-ID
    X-MOBILE-PLATFORM
    X-APPLICATION-NAME
    X-APPLICATION-VERSION
    X-DEVICE-TIME-ZONE
    X-DEVICE-LOCALE
    X-PUSH-NOTIFICATION-TOKEN)

  def mobile_push_notification_token
    headers['HTTP_X_PUSH_NOTIFICATION_TOKEN'] || headers['X-PUSH-NOTIFICATION-TOKEN ']
  end

  def mobile_device_id
    headers['HTTP_X_DEVICE_ID'] || headers['X-DEVICE-ID ']
  end

  def mobile_device_platform
    headers['HTTP_X_MOBILE_PLATFORM'] || headers['X-MOBILE-PLATFORM']
  end

  def mobile_app_name
    headers['HTTP_X_APPLICATION_NAME'] || headers['X-APPLICATION-NAME']
  end

  def mobile_app_version
    headers['HTTP_X_APPLICATION_VERSION'] || headers['X-APPLICATION-VERSION']
  end

  def mobile_device_time_zone
    headers['HTTP_X_DEVICE_TIME_ZONE'] || headers['X-DEVICE-TIME-ZONE']
  end

  def mobile_device_locale
    headers['HTTP_X_DEVICE_LOCALE'] || headers['X-DEVICE-LOCALE']
  end

  def conventional_name
    mobile_app_name.to_s.upcase.split(' ').join('_')
  end

  def conventional_platform
    mobile_device_platform.to_s.upcase
  end

  def agent_string
    ([conventional_name, mobile_app_version, conventional_platform].join '/').to_s
  end

  def mobile_headers_valid?
    sliced_headers.values.compact.count == MOBILE_HEADERS_KEYS.count / 2
  end

  def sliced_headers
    headers.to_h.slice(*MOBILE_HEADERS_KEYS)
  end
end
