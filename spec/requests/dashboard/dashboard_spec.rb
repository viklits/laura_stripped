require 'rails_helper'

describe 'Dashboard:', type: :request do

  let(:token) {"3f898544c32fe878e46e40e7186364a5"}
  let(:authenticated_headers) { LauraSpecHelper.ios_device.update 'X-AUTHENTICATION' => token }

  let(:authenticated_device) {
    {
      '1111111' => {
        platform: 'IOS',
        app_name: 'Laura IOS App',
        authentication_token: token
      }
    }
  }


  let(:valid_parking_ticket) {
    {
      bill: {
        bill_type: :parking_ticket,
        status: :payed,
        payment_status: :due_soon,
        payed_amount: 123.45,
        payed_date: Date.today,
      }
    }
  }

  let(:valid_water_bill) {
    {
      bill: {
        bill_type: :water_bill,
        status: :unpayed,
        payment_status: :due_soon,
        payed_amount: 123.45,
        payed_date: Date.today,
      }
    }
  }

  before :each do
    User.delete_all
    user = User.create LauraSpecHelper.valid_user_params.
      update(devices: authenticated_device)
    user.bills.create valid_parking_ticket[:bill]
    user.bills.create valid_water_bill[:bill]
  end

  context 'current' do
    it 'with valid params' do
      get root_path, {}, authenticated_headers
      response_hash = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(response_hash['news_from_ward47'].count).to eq(4)
      expect(response_hash['news_from_mayer'].count).to eq(4)
      expect(response_hash['payment_alert'].count).to eq(2)
    end
  end

end
