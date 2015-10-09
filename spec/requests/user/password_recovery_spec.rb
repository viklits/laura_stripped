require 'rails_helper'
RSpec.describe 'Password recovery', type: :request do

  let(:user) { User.create LauraSpecHelper.valid_user_params }

  it 'request for recovery with invalid email', :skip_reqres do
    get users_password_new_path, { email: 'invalid@email.com'}, LauraSpecHelper.ios_device
    response_hash =  JSON.parse(response.body)

    msg = I18n.t('user.errors.user_not_found')
    expect(response.status).to eq(404)
    expect(response_hash['error']).to eq(msg)
  end

  it 'request for recovery' do
    get users_password_new_path, { email: user.email}, LauraSpecHelper.ios_device
    response_hash =  JSON.parse(response.body)

    msg = I18n.t('user.notifications.password.instructions_sent')
    expect(response_hash['message']).to eq(msg)
  end
end
