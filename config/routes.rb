Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :adventures do
      resources :comments
  end
  root :to => redirect('/adventures')
  get 'users/:id', to: "users#show", as: "user"
end
