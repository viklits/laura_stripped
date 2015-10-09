require 'rails_helper'

RSpec.describe 'Register a new user', type: :request do

  let(:new_user_request) { { user: LauraSpecHelper.valid_user_params } }

  context 'First step' do
    it 'First step' do
      post '/users/registrations', new_user_request, LauraSpecHelper.ios_device
      response_hash =  JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(response_hash['email']).to eq(LauraSpecHelper.valid_user_params[:email])
      expect(response_hash['authentication_token'].length).to eq(32)
    end

    it 'invalid headers sent', :skip_reqres do
      post '/users/registrations', new_user_request
      response_hash =  JSON.parse(response.body)

      expect(response.status).to eq(422)
      expect(response_hash['error']).to eq(I18n.t('user.errors.invalid_headers'))
    end

  end #First Step

  context 'Second step' do
    let(:token) { "3f898544c32fe878e46e40e7186364a5" }

    let(:authenticated_headers) {
      LauraSpecHelper.ios_device.update 'X-AUTHENTICATION' => token
    }

    let(:authenticated_device) {
      {
        '1111111' => {
          platform: 'IOS',
          app_name: 'Laura IOS App',
          authentication_token: token
        }
      }
    }

    let(:user_authenticated_ios) {
      LauraSpecHelper.valid_user_params.update(devices: authenticated_device)
    }

    before :each do
      User.delete_all
      User.create user_authenticated_ios
    end

    it 'Second step' do
      patch users_registrations_path, LauraSpecHelper.valid_user_profile, authenticated_headers
      response_hash = JSON.parse(response.body)

      expect(response_hash['first_name']).to  eq('John')
      expect(response_hash['state']).to       eq('Washington')

      User.delete_all
    end
  end



  context 'Registrations Errors' do

    let(:password_lt_8) {
      { user:  LauraSpecHelper.valid_user_params.
        update(password: '1'*4 ).
        update(password_confirmation: '1'*4)
      }
    }

    let(:invalid_password) {
      { user:  LauraSpecHelper.valid_user_params.update(password: '1'*9 ) }
    }

    it 'Password and password confirmation are different', :skip_reqres do
      post users_registrations_path, invalid_password, LauraSpecHelper.ios_device
      response_hash = JSON.parse(response.body)

      expect(response.status).to eq(422)
      expect(response_hash['error']).to include("doesn't match Password")
    end

    it 'Password length should be mor than 7 chars', :skip_reqres do
      post users_registrations_path, password_lt_8, LauraSpecHelper.ios_device
      response_hash = JSON.parse(response.body)

      expect(response.status).to eq(422)
      err_msg = "is too short (minimum is 8 characters)"
      expect(response_hash['error']).to include(err_msg)
    end

  end #context


end
