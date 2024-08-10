Rails.application.routes.draw do
  root 'home#index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # resources :categories do
  #   resources :sub_categories do
  #     resources :brands do
  #       resources :catalogues do
  #         resources :catalogue_variants
  #       end
  #     end
  #   end
  # end

  # resources :catalogue_variant_colors
  # resources :catalogue_variant_sizes
  
  # post 'otp/send_sms', to: 'otp#send_sms'
  # post 'otp/verify_sms', to: 'otp#verify_sms'
  # post 'otp/send_email', to: 'otp#send_email'
  # post 'otp/verify_email', to: 'otp#verify_email'

  # post 'auth/login', to: 'auth#login'
  # post 'auth/logout', to: 'auth#logout'
  
   namespace :api do
    namespace :v1 do
      post "sign_up", to: "accounts#sign_up"
      get "account", to: "accounts#index"
    end
  end
end
