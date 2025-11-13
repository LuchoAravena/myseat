Rails.application.routes.draw do
  root "checkins#new"

  resources :checkins, only: [:new, :create, :show]
  resources :guests
  resources :tables do
    member do
      get  :assign
      post :add_guest
      delete :remove_guest
    end
  end
  get "/qr", to: "qr#show"
  get "up" => "rails/health#show", as: :rails_health_check
end
