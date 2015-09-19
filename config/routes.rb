Rails.application.routes.draw do
  resources :merchants
  resources :accounts

  post "/mondo/webhook" => "webhooks#receive"

  root 'welcome#index'
end
