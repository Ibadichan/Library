Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  match '/users/:id/finish_sign_up', to: 'users#finish_sign_up',
                                     via: %i[get patch], as: :finish_sign_up

  resources :users, only: %i[show]
  root to: 'searches#show'
end
