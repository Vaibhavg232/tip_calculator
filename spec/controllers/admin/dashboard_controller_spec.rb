require 'rails_helper'

RSpec.describe Admin::DashboardController, type: :controller do
  describe 'GET #index' do
    let!(:calculations) { create_list(:calculation, 3) }

    it 'assigns all calculations ordered by created_at descending to @calculations' do
      get :index
      expect(assigns(:calculations)).to eq(Calculation.order(created_at: :desc))
    end

    it 'returns a successful response' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end
end
