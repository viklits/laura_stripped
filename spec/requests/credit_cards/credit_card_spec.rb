require 'rails_helper'

describe 'Credit card:', type: :request do

  let(:token) {"3f898544c32fe878e46e40e7186364a5"}

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

  let(:cc_params) {
    {
      credit_card: {
        cc_number: CreditCardValidations::Factory.random(:mastercard),
        month: 'Jan',
        year: 2014,
        cvv: 321,
        zipcode: 4321
      }
    }
  }

  let(:cc_params_other) {
    {
      credit_card: {
        cc_number: CreditCardValidations::Factory.random(:visa),
        month: 'Dec',
        year: 2015,
        cvv: 987,
        zipcode: 7733
      }
    }
  }

  let(:invalid_cc_params) {
    {
      credit_card: {
        month: 'Jan'*200,
        cvv: 321,
        zipcode: 4321,
        cc_number: ''
      }
    }
  }

  before :each do
    User.delete_all
    @user = User.create LauraSpecHelper.valid_user_params.
      update(devices: authenticated_device)
  end


  context 'List' do

    before :each do
      @user.credit_cards.create(cc_params_other[:credit_card])
      @user.credit_cards.create(cc_params[:credit_card])
    end

    it 'list' do
      get credit_cards_path, {}, authenticated_headers
      response_hash =  JSON.parse(response.body)

      expect(response_hash.length).to eq(2)
      expect(response.status).to eq(200)
    end

    after :each do
      CreditCard.delete_all
    end

  end

  context 'actions - ' do

    let(:credit_card) { User.first.credit_cards.first }

    before :each do
      User.first.credit_cards.create cc_params[:credit_card]
    end


    context 'delete ' do

      it 'non-existing credit card', :skip_reqres do
        delete credit_card_path(12131212), {}, authenticated_headers
        response_hash = JSON.parse(response.body)

        expect(response.status).to eq(404)
        msg = I18n.t('credit_card.errors.not_found')
        expect(response_hash['error']).to  eq(msg)
      end

      it 'with valid params' do
        delete credit_card_path(credit_card.id), {}, authenticated_headers
        response_hash = JSON.parse(response.body)

        msg = I18n.t('credit_card.notifications.destroyed')
        expect(response_hash['message']).to  eq(msg)
      end
    end #delete

    context 'update ' do

      it 'with valid params' do
        patch credit_card_path(credit_card), cc_params_other, authenticated_headers
        response_hash = JSON.parse(response.body)

        card = cc_params_other[:credit_card]
        expect(response_hash['year']).to  eq(card[:year])
        expect(response_hash['cvv']).to  eq(card[:cvv].to_s)
        expect(response_hash['cc_number']).to  eq(card[:cc_number])
      end

      it 'non-existing card', :skip_reqres do
        patch credit_card_path(232323), invalid_cc_params, authenticated_headers
        response_hash = JSON.parse(response.body)

        expect(response.status).to eq(404)
      end

      it 'with invalid params', :skip_reqres do
        patch credit_card_path(credit_card.id), invalid_cc_params, authenticated_headers
        response_hash = JSON.parse(response.body)

        expect(response.status).to eq(422)
      end
    end
  end




  context 'create new ' do
    it 'with valid params' do
      post credit_cards_path, cc_params, authenticated_headers
      response_hash = JSON.parse(response.body)

      card = cc_params[:credit_card]
      expect(response_hash['year']).to  eq(card[:year])
      expect(response_hash['cvv']).to  eq(card[:cvv].to_s)
      expect(response_hash['cc_number']).to  eq(card[:cc_number])
    end

    it 'with invalid params', :skip_reqres do
      post credit_cards_path, invalid_cc_params, authenticated_headers
      response_hash = JSON.parse(response.body)
      card = cc_params[:credit_card]
      expect(response.status).to eq(422)
    end
  end

end
