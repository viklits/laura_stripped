require 'rails_helper'

RSpec.describe 'User sessions:', type: :request do

  context 'actions - ' do

    let(:token) { "3f898544c32fe878e46e40e7186364a5" }
    let(:authenticated_headers) {
      LauraSpecHelper.ios_device.update 'X-AUTHENTICATION' => token
    }

    let(:another_token) { "3f898544c32fe878e46e40e7186364a1" }
    let(:another_authenticated_headers) {
      LauraSpecHelper.android_device.update 'X-AUTHENTICATION' => another_token
    }

    let(:another_authenticated_device) {
      {
        '222222' => {
          platform: 'Android',
          app_name: 'Laura Android App',
          authentication_token: another_token
        }
      }
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

    let(:another_user_authenticated_ios) {
      LauraSpecHelper.valid_user_params.update(devices: another_authenticated_headers)
    }

    let(:user_authenticated_ios) {
      LauraSpecHelper.valid_user_params.update(devices: authenticated_device)
    }

    before :each do
      User.delete_all
      User.create  user_authenticated_ios
    end

    context 'sign out' do
      it 'a user with valid token' do
        delete users_sessions_path, nil, authenticated_headers
        response_hash =  JSON.parse(response.body)

        msg = I18n.t('user.notifications.sign_out')
        expect(response_hash['message']).to eq(msg)
      end
    end #Sign out


    context 'user profile' do
      it 'get a user profile' do
        get users_sessions_path, {}, authenticated_headers
        response_hash =  JSON.parse(response.body)

        email = LauraSpecHelper.valid_user_params[:email]
        expect(response_hash['email']).to eq(email)
      end
    end #user profile

  end


  context 'actions - sign in' do

    before :each do
      User.delete_all
      User.create LauraSpecHelper.another_valid_user_params
      User.create LauraSpecHelper.valid_user_params.update(phone: '111222333')
    end

    context 'with phone' do
      let(:valid_signin_params) {
        {
          auth_credentials: {
            phone:     '111222333',
            password:  LauraSpecHelper.valid_user_params[:password]
          }
        }
      }

      let(:invalid_signin_params) {
        {
          auth_credentials: {
            phone:     '12312312312423423425',
            password:  LauraSpecHelper.valid_user_params[:password]
          }
        }
      }

      it 'invalid', :skip_reqres do
        post users_sessions_path, invalid_signin_params, LauraSpecHelper.ios_device
        response_hash =  JSON.parse(response.body)

        msg = I18n.t('user.errors.invalid_credentials')
        expect(response_hash['error']).to eq(msg)
      end


      it 'valid' do
        post users_sessions_path, valid_signin_params, LauraSpecHelper.ios_device
        response_hash =  JSON.parse(response.body)

        email = LauraSpecHelper.valid_user_params[:email]
        expect(response_hash['email']).to eq(email)
      end
    end


    context 'with email' do
      let(:another_valid_signin_params) {
        {
          auth_credentials: {
            email:     LauraSpecHelper.another_valid_user_params[:email],
            password:  LauraSpecHelper.another_valid_user_params[:password]
          }
        }
      }

      let(:valid_signin_params) {
        {
          auth_credentials: {
            email:     LauraSpecHelper.valid_user_params[:email],
            password:  LauraSpecHelper.valid_user_params[:password]
          }
        }
      }

      let(:invalid_signin_params) {
        {
          auth_credentials: {
            email:     'user@somewhere.com',
            password:  LauraSpecHelper.valid_user_params[:password]
          }
        }
      }

      it 'invalid', :skip_reqres do
        post users_sessions_path, invalid_signin_params, LauraSpecHelper.ios_device
        response_hash =  JSON.parse(response.body)

        msg = I18n.t('user.errors.invalid_credentials')
        expect(response_hash['error']).to eq(msg)
      end


      it 'valid' do
        post users_sessions_path, valid_signin_params, LauraSpecHelper.ios_device
        response_hash =  JSON.parse(response.body)

        email = LauraSpecHelper.valid_user_params[:email]
        expect(response_hash['email']).to eq(email)
      end


      it 'valid 2 users logged in within same device', :skip_reqres do
        # sign in 1st user
        post users_sessions_path, valid_signin_params, LauraSpecHelper.ios_device
        response_hash =  JSON.parse(response.body)

        email = LauraSpecHelper.valid_user_params[:email]
        first_auth_token = response_hash['authentication_token']
        expect(response_hash['email']).to eq(email)

        # sign in 2nd user
        post users_sessions_path, another_valid_signin_params, LauraSpecHelper.ios_device
        response_hash =  JSON.parse(response.body)

        second_auth_token = response_hash['authentication_token']
        email = LauraSpecHelper.another_valid_user_params[:email]
        expect(response_hash['email']).to eq(email)

        expect(first_auth_token).not_to eq(second_auth_token)
      end
    end

  end

end
