Rails.application.routes.draw do
    devise_for :users, :controllers => { registrations: 'registrations' } do
        get "/users/sign_out" => "devise/sessions#destroy", :as => :destroy_user_session
    end
    devise_scope :user do
        get '/sign-in' => "devise/sessions#new", :as => :login
    end
    get '/users/:id', :to => 'users#show', :as => :user
    resources :users, only: [:index]
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    resources :adventures do
      resources :comments
    end
    resources :chat_rooms, only: [:new, :create, :show, :index] do
        post "/create_message", :to => "chat_rooms#create_msg", :as => "create_msg"
    end
    root :to => redirect('/adventures')
    resources :friendships
    resources :users
    mount ActionCable.server => '/cable'
  end
