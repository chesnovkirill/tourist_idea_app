Rails.application.routes.draw do
  resources :adventures
  root :to => redirect('/adventures')
end
