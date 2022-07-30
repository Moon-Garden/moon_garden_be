Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/blah', to: 'users#index'
      post '/find_or_create_user', to: 'users#find_or_create_user'
<<<<<<< HEAD
      resources :users do
        resources :gardens do
          resources :plants
        end
      end
=======
      resources :gardens
      resources :users, only: %i[show]
>>>>>>> 1ca99633b6ed157a99b92b608d7b098fac189ef2
    end
  end
end
