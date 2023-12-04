# frozen_string_literal: true

# controller rspec
require 'rails_helper'

RSpec.describe 'POST /api/v1/businesses', type: :request do
  let(:user) { create(:user) }
  let(:headers) { { 'Authorization' => user.auth_token} }
  let(:valid_request_body) do
    {
      name: 'XYZ Test',
      shares_available: 10
    }.as_json
  end

  let(:invalid_request_body) do
    {
      name: nil,
      shares_available: 10
    }.as_json
  end

  let(:invalid_request_body_two) do
    {
      name: 'Demo',
      shares_available: -10
    }.as_json
  end

  describe 'with valid params' do
    it 'creates new business' do
      post '/api/v1/businesses', params: valid_request_body, headers: headers
      expect(response.status).to eq(201)
      expect(Business.count).to eq(1)
      expect(Business.last.name).to eq('XYZ Test')
      expect(Business.last.shares_available).to eq(10)
    end
  end

  describe 'with invalid params' do
    it 'does not create new business' do
      post '/api/v1/businesses', params: invalid_request_body, headers: headers
      expect(response.status).to eq(422)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body["data"]).to be_nil
      expect(parsed_body["message"]).to eq("Validation failed: Name can't be blank")
    end

    it 'raises error while creating new business' do
      post '/api/v1/businesses', params: invalid_request_body_two, headers: headers
      expect(response.status).to eq(422)
      parsed_body = JSON.parse(response.body)
      expect(parsed_body["data"]).to be_nil
      expect(parsed_body["message"]).to eq("Validation failed: Shares available must be greater than or equal to 0")
    end
  end
end
