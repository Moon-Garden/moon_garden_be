Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/blah', to: 'users#index'
      post '/find_or_create_user', to: 'users#find_or_create_user'
      resources :users, only: %i[show]
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
