Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api do
    namespace :v1 do

      post 'signup', to: 'accounts#signup'
      post 'login', to: 'accounts#login'
      post 'send_email_otp', to: 'accounts#send_email_otp'
      post 'send_sms_otp', to: 'accounts#send_sms_otp'
      get 'account', to: "accounts#index"

        resources :categories do
        resources :sub_categories, only: [:index, :show, :create, :update, :destroy]

        resource :wallet, only: [:show] do
        member do
          post 'add_funds'   
          post 'spend_funds' # Route for spending funds from the wallet
        end
      end
  end

      resources :catalogues do
        resources :catalogue_variants, only: [:index, :create]
        resources :catalogue_variant_colors, only: [:index, :show, :create, :update, :destroy]
        resources :catalogue_variant_sizes, only: [:index, :show, :create, :update, :destroy]
      end

      resources :catalogue_variants, only: [:index, :show, :update, :destroy]

      resources :brands, only: [:index, :show, :create, :update, :destroy]

      resources :checkouts, only: [:create]

    end
  end
end
