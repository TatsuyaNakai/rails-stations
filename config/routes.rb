Rails.application.routes.draw do
  root 'movies#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :movies, only: [:index, :show] do
    get 'schedule', to: 'movies#schedule', on: :member

    resources :reservations, only: [:new]
    # /movies/:movie_id/reservation
    get 'reservation', to: 'movies#reservation', on: :member
  end

  post 'reservation', to: 'reservations#create'

  resources :sheets, only: [:index]

  namespace :admin do
    resources :movies do
      # 仕様 GET /admin/movies/:id/schedules/newへのリンクを追加対応
      get 'schedules/new', to: 'movies#new_schedule', on: :member

      # クリア条件 GET /admin/movies/:movie_id/schedules/:schedule_id 対応
      get 'schedules/:schedule_id', to: 'movies#show_schedule'
    end

    resources :schedules
    resources :reservations
  end

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
