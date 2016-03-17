Rails.application.routes.draw do
  root 'pages#index'
  get '/pages', to: 'pages#index', as: 'pages'
end
