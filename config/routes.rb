Rails.application.routes.draw do
    devise_for :users, :controllers => { registrations: 'registrations' } do
        get "/users/sign_out" => "devise/sessions#destroy", :as => :destroy_user_session
    end
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    resources :adventures do
      resources :comments
    end
    resources :chat_rooms, only: [:new, :create, :show, :index]
    root :to => redirect('/adventures')
    get 'users/:id', to: "users#show", as: "user"
    mount ActionCable.server => '/cable'
  end
