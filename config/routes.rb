Rails.application.routes.draw do
  resources :movies, only: [:index, :show]

  resources :sheets, only: [:index]

  namespace :admin do
    resources :movies, except: [:show]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
