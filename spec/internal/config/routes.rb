Rails.application.routes.draw do
  mount AmaLayout::Engine, at: 'ama_layout'
  root 'pages#index'
  get '/pages', to: 'pages#index', as: 'pages'
end
