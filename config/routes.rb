Overview::Application.routes.draw do

  resources :servers do
    resources :websites do
      collection do
        post 'create_or_update'
      end

      resources :plugins do
        member do
          get 'description'
        end
      end
    end
  end

  match 'search'   => 'search#index'
  match 'search/search' => 'search#search'
  root :to => 'home#index'
end
