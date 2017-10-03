Rails.application.routes.draw do
  devise_for :users
  root to: 'searches#show'
end
