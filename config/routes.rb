Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :shows, only: [:index, :show] do
    resources :episodes, only: [:show] do
      member do
        get :play
      end
    end
  end
  root to: "shows#index"
end
