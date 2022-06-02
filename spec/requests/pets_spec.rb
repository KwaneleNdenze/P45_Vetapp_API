require 'rails_helper'

RSpec.describe 'Pets API', type: :request do
  # add pets owner
  let(:user) { create(:user) }
  # initialize test data
  let!(:pets) { create_list(:pet, 10, user_id: user.id) }
  let(:pet_id) { pets.first.id }
  # authorize request
  let(:headers) { valid_headers }

  # Test suite for GET /pets
  describe 'GET /pets' do
    # make HTTP get request before each example
    before { get '/pets', params: {}, headers: headers }

    it 'returns pets' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /pets/:id
  describe 'GET /pets/:id' do
    before { get "/pets/#{pet_id}", params: {}, headers: headers }

    context 'when the record exists' do
      it 'returns the pet' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(pet_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:pet_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Pet/)
      end
    end
  end

  # Test suite for POST /todos
  describe 'POST /pets' do
    let(:valid_attributes) do
      # send json payload
      { name: 'Danger', pet_type: "Dog" }.to_json
    end

    context 'when the request is valid' do
      before { post '/pets', params: valid_attributes, headers: headers }

      it 'creates a pet' do
        expect(json['name']).to eq('Danger') # might need to add pet_type here!
        expect(json['pet_type']).to eq('Dog')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      let(:invalid_attributes) { { name: nil, pet_type: nil}.to_json }
      before { post '/pets', params: invalid_attributes, headers: headers } # might need to add pet_type here!

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Name can't be blank, Pet type can't be blank/)
      end
    end
  end

  # Test suite for PUT /pets/:id
  describe 'PUT /pets/:id' do
    let(:valid_attributes) { { name: 'Cassper', pet_type: 'Dog' }.to_json }

    context 'when the record exists' do
      before { put "/pets/#{pet_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /pets/:id
  describe 'DELETE /pets/:id' do
    before { delete "/pets/#{pet_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end