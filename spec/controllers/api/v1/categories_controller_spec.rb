require 'rails_helper'

RSpec.describe Api::V1::CategoriesController, type: :controller do
  describe "GET #index" do
    let!(:categories) { create_list(:category, 3, :with_sub_categories) }

    it "returns a list of categories with sub_categories" do
      get :index
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response["categories"].length).to eq(3)
      expect(json_response["categories"].first["sub_categories"]).not_to be_empty
    end
  end

  describe "GET #show" do
    context "when the category exists" do
      let!(:category) { create(:category, :with_sub_categories) }

      it "returns the category with sub_categories" do
        get :show, params: { id: category.id }
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response["id"]).to eq(category.id)
        expect(json_response["sub_categories"]).not_to be_empty
      end
    end

    context "when the category does not exist" do
      it "returns a not found error" do
        get :show, params: { id: 0 }  # Assuming no category with id=0 exists
        expect(response).to have_http_status(:not_found)
        json_response = JSON.parse(response.body)
        expect(json_response["error"]).to eq('Category not found')
      end
    end
  end

  describe "POST #create" do
    let(:valid_attributes) { { name: 'New Category', sub_categories_attributes: [{ name: 'Sub Category 1' }] } }
    let(:invalid_attributes) { { name: '' } }

    context "with valid attributes" do
      it "creates a new category with sub_categories" do
        expect {
          post :create, params: { category: valid_attributes }
        }.to change(Category, :count).by(1)
        expect(response).to have_http_status(:created)
        json_response = JSON.parse(response.body)
        expect(json_response["name"]).to eq('New Category')
        expect(json_response["sub_categories"]).not_to be_empty
      end
    end

    context "with invalid attributes" do
      it "does not create a new category and returns errors" do
        expect {
          post :create, params: { category: invalid_attributes }
        }.not_to change(Category, :count)
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response["errors"]).not_to be_empty
      end
    end
  end

  describe "PUT #update" do
    let!(:category) { create(:category) }
    let(:valid_attributes) { { name: 'Updated Category' } }
    let(:invalid_attributes) { { name: '' } }

    context "with valid attributes" do
      it "updates the category and returns the updated category" do
        put :update, params: { id: category.id, category: valid_attributes }
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response["name"]).to eq('Updated Category')
      end
    end

    context "with invalid attributes" do
      it "does not update the category and returns errors" do
        put :update, params: { id: category.id, category: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response["errors"]).not_to be_empty
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:category) { create(:category) }

    it "deletes the category and returns a success message" do
      expect {
        delete :destroy, params: { id: category.id }
      }.to change(Category, :count).by(-1)
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response["message"]).to eq('Category deleted successfully')
    end
  end
end
