require 'rails_helper'

RSpec.describe 'Appointments API', type: :request do
  # initialize test data
  let(:user) { create(:user) }
  let(:pet) { create(:pet, user_id: user.id) }
  
  let!(:appointments) { create_list(:appointment, 10, user_id: user.id, pet_id: pet.id) }
  

  let(:appointment_id) { appointments.first.id }
  let(:pet_id) { pets.first.id }
  let(:headers) { valid_headers }

  # Test suite for GET /appointments
  describe 'GET /appointments' do
    # make HTTP get request before each example
    before { get '/appointments', params: {}, headers: headers }

    it 'returns appointments' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /appointments/:id
  describe 'GET /appointments/:id' do
    before { get "/appointments/#{appointment_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the appointment' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(appointment_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:appointment_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Appointment/)
      end
    end
  end

  # Test suite for POST /appointments
  describe 'POST /appointments' do

    let(:valid_attributes) do
      # send json payload
      { vet_id: user.id, pet_id: pet.id, date: '2022-05-30' }.to_json
    end

    context 'when the request is valid' do
      before { post '/appointments', params: valid_attributes, headers: headers }
      
      it 'creates a appointment' do
        expect(json['vet_id']).to eq(1)
        expect(json['date']).to eq('2022-05-30')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { vet_id: nil, date: nil }.to_json }
      before { post '/appointments', params: invalid_attributes, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Pet must exist, Vet can't be blank, Pet can't be blank, Date can't be blank/)
      end
    end
  end

  # Test suite for PUT /appointments/:id
  describe 'PUT /appointments/:id' do
    let(:valid_attributes) do 
      { vet_id: 1, date: '2022-06-03' }.to_json 
    end

    context 'when the record exists' do
      before { put "/appointments/#{appointment_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /appointments/:id
  describe 'DELETE /appointments/:id' do
    before { delete "/appointments/#{appointment_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end