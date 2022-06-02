require 'rails_helper'

RSpec.describe 'VetRegistration API', type: :request do
  # initialize test data
  let(:user) { create(:user) }
  let(:pet) { create(:pet) }
 
  let!(:pets) { create_list(:pet, 10, user_id: user.id) }
  let(:pet_id) { pets.first.id }

  let!(:vet_registrations) { create_list(:vet_registration, 10, user_id: user.id, pet_id: pets.first.id, vet_id: 1) }
  let(:vet_registration_id) { vet_registrations.first.id }

  

  # authorize request
  let(:headers) { valid_headers }
  

  # Test suite for GET /vet_registrations
  describe 'GET /vet_registrations' do
    # make HTTP get request before each example
    before { get '/vet_registrations', params: {}, headers: headers }

    it 'returns vet_registrations' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /vet_registrations/:id
  describe 'GET /vet_registrations/:id' do
    before { get "/vet_registrations/#{vet_registration_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the vet_registration' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(vet_registration_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:vet_registration_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find VetRegistration/)
      end
    end
  end

  # Test suite for POST /vet_registrations
  describe 'POST /vet_registrations' do
    let(:valid_attributes) do
      # send json payload
       { vet_id: 1, pet_id: pet_id, user_id: user.id }.to_json 
    end

    context 'when the request is valid' do
      before { post '/vet_registrations', params: valid_attributes, headers: headers }

      it 'creates a vet_registration' do
        expect(json['vet_id']).to eq(1)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { vet_id: nil }.to_json }

      before { post '/vet_registrations', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Pet must exist, Vet can't be blank, Pet can't be blank/)
      end
    end
  end

  # Test suite for PUT /vet_registrations/:id
  describe 'PUT /vet_registrations/:id' do
    let(:valid_attributes) { {user_id: 2 }.to_json }

    context 'when the record exists' do
      before { put "/vet_registrations/#{vet_registration_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /vet_registrations/:id
  describe 'DELETE /vet_registrations/:id' do
    before { delete "/vet_registrations/#{vet_registration_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end