module ActiveRecord
  class Base
    # RE_STRING = /\A[a-zA-Z0-9_%a-z \.:\(\)\[\]\\\/\|]+\z/
    # RE_PRICE = /\A(\d+\z)|(\A\d+\.\d{0,2})\z/
    RE_EMAIL =/\A[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,5}\z/
    STRING_LENGTH = 255
  end
end
