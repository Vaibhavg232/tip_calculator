require 'rails_helper'

RSpec.describe CalculationsController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_attributes) do
        { bill_amount: 100, tip_percentage: 15, number_of_people: 2 }
      end

      it 'creates a new calculation' do
        expect {
          post :create, params: { calculation: valid_attributes }
        }.to change(Calculation, :count).by(1)
      end

      it 'returns a JSON response with the new calculation' do
        post :create, params: { calculation: valid_attributes }
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to include('calculation')
      end
    end

    context 'with invalid parameters' do
      let(:invalid_attributes) do
        { bill_amount: nil, tip_percentage: 15, number_of_people: 2 }
      end

      it 'does not create a new calculation' do
        expect {
          post :create, params: { calculation: invalid_attributes }
        }.not_to change(Calculation, :count)
      end

      it 'returns a JSON response with errors for the new calculation' do
        post :create, params: { calculation: invalid_attributes }
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to include('errors')
      end
    end
  end
end
