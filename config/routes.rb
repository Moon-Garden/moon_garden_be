Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/blah', to: 'users#index'
      post '/find_or_create_user', to: 'users#find_or_create_user'
      resources :users do
        resources :gardens do
          resources :plants
        end
      end
    end
  end
end
