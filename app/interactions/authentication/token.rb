class Authentication::Token
  def generate
    SecureRandom.hex
  end
end
