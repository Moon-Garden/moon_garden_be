Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/user', to: 'users#show'
      resources :users, only: %i[create]
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
