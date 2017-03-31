# spec/requests/usuario_spec.rb
require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  # initialize test data 
  let!(:users) { create_list(:user, 10) }
  let(:user_id) { users.first.id }

  # Test suite for GET /usuario
  describe 'GET /usuario' do
    # make HTTP get request before each example
    before { get '/usuario' }

    it 'returns users' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /usuario/:id
  describe 'GET /usuario/:id' do
    before { get "/usuario/#{user_id}" }

    context 'when the record exists' do
      it 'returns the user' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(user_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:user_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  # Test suite for PUT /usuario
  describe 'PUT /usuario' do
    # valid payload
    let(:valid_attributes) { { username: 'bcsaldias', 
                               name: 'Belén',
                               last_name: 'Saldias',
                               twitter: 'bcsaldias' } }

    context 'when the request is valid' do
      before { put '/usuario', params: valid_attributes }

      it 'creates a user' do
        expect(json['username']).to eq('bcsaldias')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { put '/usuario', params: { username: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for POST /usuario/:id
  describe 'POST /usuario/:id' do
    let(:valid_attributes) { { username: 'bcsaldias', 
                               name: 'Belén'} }

    context 'when the record exists' do
      before { post "/usuario/#{user_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /usuario/:id
  describe 'DELETE /usuario/:id' do
    before { delete "/usuario/#{user_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end