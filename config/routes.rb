Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  match '/users/:id/finish_sign_up', to: 'users#finish_sign_up',
                                     via: %i[get patch], as: :finish_sign_up

  resources :users, only: %i[show] do
    resources :books, only: %i[index destroy] do
      post :add_in_favorites, on: :collection
      patch :mark, on: :member
    end

    resources :plans
  end

  resource :search, only: :show

  namespace :admin do
    resources :users, only: %i[new create index] do
      patch :block, :unblock, on: :member
    end

    root to: 'panels#show'
  end

  root to: 'searches#show'
end
