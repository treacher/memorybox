Memorybox::Application.routes.draw do

  %w[privacy terms].each do |page|
    get page, controller: "pages", action: page
  end
  
  authenticated :user do
    root to: 'main#index'
  end
  
  root to: 'pages#home'

  resources :main, only: [:index]

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

	devise_for :user, controllers: { 
    registrations: "users/registrations", 
    invitations: "users/invitations", 
    passwords: "users/passwords"
  }

  namespace :api do
  	resource :user, only: [:create] do
      resources :cloudinary, only: [:index]
      resources :invitations, only: [:update] do
        collection do
          get :received_invitations
          get :sent_invitations
        end
        put :accept
        put :decline
        put :retract
      end
  		resources :memory_boxes, except: [:edit, :new] do
        resources :invitations, only: [:create]
  			resources :entries, except: [:edit, :new]
        delete :leave_memory_box
  		end
  	end
  end
end