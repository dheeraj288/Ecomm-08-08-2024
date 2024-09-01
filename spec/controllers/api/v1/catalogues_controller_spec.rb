require 'rails_helper'

RSpec.describe Api::V1::CataloguesController, type: :controller do
  let(:category) { create(:category) }
  let(:sub_category) { create(:sub_category) }
  let(:brand) { create(:brand) }

  let(:catalogue) { create(:catalogue, category: category, sub_category: sub_category, brand: brand) }

  describe 'GET #show' do
    it 'returns a 404 response if the catalogue is not found' do
      get :show, params: { id: -1 } # Use a non-existent ID
      expect(response).to have_http_status(:not_found)
    end

    it 'returns a success response if the catalogue is found' do
      get :show, params: { id: catalogue.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(catalogue.id)
    end
  end

  describe 'POST #create' do
    context 'with invalid parameters' do
      it 'does not create a new Catalogue and returns errors' do
        post :create, params: { catalogue: { name: '', category_id: nil, sub_category_id: nil, brand_id: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).to include("Name can't be blank")
        expect(JSON.parse(response.body)['errors']).to include("Category must exist")
        expect(JSON.parse(response.body)['errors']).to include("Sub category must exist")
        expect(JSON.parse(response.body)['errors']).to include("Brand must exist")
      end
    end

    context 'with valid parameters' do
      it 'creates a new Catalogue' do
        post :create, params: { catalogue: { name: 'New Catalogue', category_id: category.id, sub_category_id: sub_category.id, brand_id: brand.id } }
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['name']).to eq('New Catalogue')
      end
    end
  end

  describe 'PUT #update' do
    context 'with invalid parameters' do
      it 'returns a 422 status with errors' do
        put :update, params: { id: catalogue.id, catalogue: { name: '' } } # Assuming 'name' is required
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).to include("Name can't be blank")
      end
    end

    context 'with valid parameters' do
      it 'updates the requested catalogue' do
        put :update, params: { id: catalogue.id, catalogue: { name: 'Updated Name' } }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['name']).to eq('Updated Name')
      end
    end
  end
end
