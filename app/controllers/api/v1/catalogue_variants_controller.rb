module Api
  module V1
    class CatalogueVariantsController < ApplicationController
      def index
        catalogue_variants = CatalogueVariant.includes(:catalogue_variant_color, :catalogue_variant_size).all
        render json: catalogue_variants, status: :ok
      end

      def show
        catalogue_variant = CatalogueVariant.includes(:catalogue_variant_color, :catalogue_variant_size).find(params[:id])
        render json: catalogue_variant, status: :ok
      end

      def create
        catalogue_variant = CatalogueVariant.new(catalogue_variant_params)
        if catalogue_variant.save
          render json: catalogue_variant, status: :created
        else
          render json: { errors: catalogue_variant.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        catalogue_variant = CatalogueVariant.find(params[:id])
        if catalogue_variant.update(catalogue_variant_params)
          render json: catalogue_variant, status: :ok
        else
          render json: { errors: catalogue_variant.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        catalogue_variant = CatalogueVariant.find(params[:id])
        catalogue_variant.destroy
        render json: { message: 'Catalogue Variant deleted successfully' }, status: :ok
      end

      private

      def catalogue_variant_params
        params.require(:catalogue_variant).permit(:catalogue_id, :catalogue_variant_color_id, :catalogue_variant_size_id)
      end
    end
  end
end
