Overview::Application.routes.draw do

  resources :servers do
    member do
      get 'visualize'
    end

    resources :websites do
      collection do
        post 'create_or_update'
      end
      member do
        get 'comments'
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
