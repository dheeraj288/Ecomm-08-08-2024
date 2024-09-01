require 'rails_helper'

RSpec.describe Api::V1::CatalogueVariantsController, type: :request do
  let!(:catalogue) { create(:catalogue) }
  let!(:catalogue_variant_color) { create(:catalogue_variant_color) }
  let!(:catalogue_variant_size) { create(:catalogue_variant_size) }
  let!(:catalogue_variant) { create(:catalogue_variant, catalogue: catalogue, catalogue_variant_color: catalogue_variant_color, catalogue_variant_size: catalogue_variant_size) }

  describe 'GET /api/v1/catalogue_variants' do
    before { get '/api/v1/catalogue_variants' }

    it 'returns a list of catalogue variants' do
      expect(response).to have_http_status(:ok)
      expect(json).not_to be_empty
      expect(json.size).to eq(1) # Adjust based on your setup
    end
  end

  describe 'GET /api/v1/catalogue_variants/:id' do
    before { get "/api/v1/catalogue_variants/#{catalogue_variant.id}" }

    it 'returns a single catalogue variant' do
      expect(response).to have_http_status(:ok)
      expect(json).not_to be_empty
      expect(json['id']).to eq(catalogue_variant.id)
    end
  end

  # describe 'POST /api/v1/catalogue_variants' do
  #   let(:valid_attributes) do
  #     { catalogue_id: catalogue.id, catalogue_variant_color_id: catalogue_variant_color.id, catalogue_variant_size_id: catalogue_variant_size.id }
  #   end

  #   context 'when the request is valid' do
  #     before { post '/api/v1/catalogue_variants', params: { catalogue_variant: valid_attributes } }

  #     it 'creates a catalogue variant' do
  #       expect(response).to have_http_status(:created)
  #       expect(json['catalogue_id']).to eq(catalogue.id)
  #     end
  #   end

  #   context 'when the request is invalid' do
  #     before { post '/api/v1/catalogue_variants', params: { catalogue_variant: { catalogue_id: nil } } }

  #     it 'returns an unprocessable entity status' do
  #       expect(response).to have_http_status(:unprocessable_entity)
  #       expect(json['errors']).to include("Catalogue can't be blank")
  #     end
  #   end
  # end

  describe 'PUT /api/v1/catalogue_variants/:id' do
    let(:valid_attributes) { { catalogue_id: catalogue.id } }

    context 'when the request is valid' do
      before { put "/api/v1/catalogue_variants/#{catalogue_variant.id}", params: { catalogue_variant: valid_attributes } }

      it 'updates the catalogue variant' do
        expect(response).to have_http_status(:ok)
        expect(json['catalogue_id']).to eq(catalogue.id)
      end
    end

    context 'when the request is invalid' do
      before { put "/api/v1/catalogue_variants/#{catalogue_variant.id}", params: { catalogue_variant: { catalogue_id: nil } } }

      it 'returns an unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['errors']).to include("Catalogue can't be blank")
      end
    end
  end

  describe 'DELETE /api/v1/catalogue_variants/:id' do
    before { delete "/api/v1/catalogue_variants/#{catalogue_variant.id}" }

    it 'deletes the catalogue variant' do
      expect(response).to have_http_status(:ok)
      expect(json['message']).to eq('Catalogue Variant deleted successfully')
    end
  end

  # Helper method to parse JSON responses
  def json
    JSON.parse(response.body)
  end
end
