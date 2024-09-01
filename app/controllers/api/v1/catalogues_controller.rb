class Api::V1::CataloguesController < ApplicationController
  # GET /catalogues/:id
  def show
    begin
      catalogue = Catalogue.includes(:category, :sub_category, :brand, :catalogue_variants).find(params[:id])
      render json: catalogue
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end
  end

  # POST /catalogues
  def create
    catalogue = Catalogue.new(catalogue_params)
    if catalogue.save
      render json: catalogue, status: :created
    else
      render json: { errors: catalogue.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PUT /catalogues/:id
  def update
    catalogue = Catalogue.find(params[:id])
    if catalogue.update(catalogue_params)
      render json: catalogue
    else
      render json: { errors: catalogue.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def catalogue_params
    params.require(:catalogue).permit(:name, :category_id, :sub_category_id, :brand_id)
  end
end
