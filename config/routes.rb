Rails.application.routes.draw do
  resources :people
  root to: "people#index"

  devise_for :users, :controllers => {
    :omniauth_callback => "omniauth_callbacks"
  }


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
