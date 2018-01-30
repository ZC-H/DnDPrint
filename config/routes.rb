Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  get "/sign_up" => "users#new", as: "sign_in"
  get "/sign_in" => "users#sign_in"
  post "/sign_in" => "users#sign_in_check"
  post "/sign_out" => "users#sign_out"
  get "auth/:provider/callback" => "users#google"
end