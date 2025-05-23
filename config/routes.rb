Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    sessions: 'users/sessions'
  }
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :admin_users

  namespace :api do
    namespace :v1 do
      
      resources :hotels do
        resources :rooms do
          collection do
            post 'perform_simple_job', to: 'rooms#perform_simple_job'
            # get 'show', to: 'rooms#show_hotel_rooms'
          end
        end
      end

      resources :rooms do
        post 'book', to: 'bookings#create'
      end
      
      resources :bookings, only: [] do
        member do
          delete 'cancel', to: 'bookings#cancle_booking'
        end
      end
    
      resources :bookings do
        post 'pay', to: 'payments#create'
      end
    
      resources :users do
        post 'send_welcom_email', to: 'users#send_welcom_email'
      end
    end
  end


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
