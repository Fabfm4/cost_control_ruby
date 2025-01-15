Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  root "rails/health#show"
  scope :api, default: { format: :json } do
    scope :v1 do
      post "auth/signin", to: "auth#signin"
      post "auth/signup", to: "auth#signup"
      get "profile/me", to: "profile#me"
      post "admin/user", to: "auth#admin"
      resources :users
      resources :banks
      # TODO: resources :transactions
      resources :cards do
        resources :transactions
      end
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
