module Api
  module V1
    class CategoriesController < ApplicationController
      include Pagy::Backend

      before_action :set_category, only: [:show, :update, :destroy]

      def index
        pagy, categories = pagy(Category.includes(:sub_categories).all)
        render json: {
          categories: categories.as_json(include: :sub_categories),
          
        }, status: :ok
      end

      def show
        render json: @category.as_json(include: :sub_categories), status: :ok
      end

      def create
        category = Category.new(category_params)
        if category.save
          render json: category.as_json(include: :sub_categories), status: :created
        else
          render json: { errors: category.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        if @category.update(category_params)
          render json: @category.as_json(include: :sub_categories), status: :ok
        else
          render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        @category.destroy
        render json: { message: 'Category deleted successfully' }, status: :ok
      end

      private

     def set_category
        @category = Category.includes(:sub_categories).find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Category not found" }, status: :not_found
      end

      def category_params
        params.require(:category).permit(:name, sub_categories_attributes: [:id, :name, :_destroy])
      end
    end
  end
end
