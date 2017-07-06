AmaLayout::Engine.routes.draw do
  scope module: 'ama_layout' do
    namespace :api do
      namespace :v1 do
        delete :notifications, to: 'notifications#dismiss_all'
      end
    end
  end
end
