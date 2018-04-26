Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index', as: 'home'

  # Search Characters
  get "search_friends", to: 'characters#search'
end
