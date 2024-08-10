module Api
  module V1
    class CataloguesController < ApplicationController
      def index
        catalogues = Catalogue.includes(:category, :sub_category, :brand, :catalogue_variants).all
        render json: catalogues, status: :ok
      end

      def show
        catalogue = Catalogue.includes(:category, :sub_category, :brand, :catalogue_variants).find(params[:id])
        render json: catalogue, status: :ok
      end

      def create
        catalogue = Catalogue.new(catalogue_params)
        if catalogue.save
          render json: catalogue, status: :created
        else
          render json: { errors: catalogue.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        catalogue = Catalogue.find(params[:id])
        if catalogue.update(catalogue_params)
          render json: catalogue, status: :ok
        else
          render json: { errors: catalogue.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        catalogue = Catalogue.find(params[:id])
        catalogue.destroy
        render json: { message: 'Catalogue deleted successfully' }, status: :ok
      end

      private

      def catalogue_params
         params.require(:catalogue).permit(
		    :name,
		    :description,
		    :category_id,
		    :sub_category_id,
		    :brand_id,
		    catalogue_variants_attributes: [:id, :catalogue_variant_color_id, :catalogue_variant_size_id, :_destroy]
		  )
      end
    end
  end
end
