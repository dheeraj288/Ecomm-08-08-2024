Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)


  namespace :api do
    namespace :v1 do
      resources :categories do
        resources :sub_categories, only: [:index, :show, :create, :update, :destroy]
      end

      resources :catalogues do
        resources :catalogue_variants, only: [:index, :create]
        resources :catalogue_variant_colors, only: [:index, :show, :create, :update, :destroy]
        resources :catalogue_variant_sizes, only: [:index, :show, :create, :update, :destroy]
      end

      resources :catalogue_variants, only: [:index, :show, :update, :destroy]

      resources :brands, only: [:index, :show, :create, :update, :destroy]
    end
  end
end
