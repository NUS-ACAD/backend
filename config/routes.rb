Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
#   resources :feeds, :follows, :invites, :likes, :members, :mods, :plans, :semesters, :users
  scope "/api" do
    resource :users, only: [:create]
    post "login", to: "users#login"
    get "auto_login", to: "users#auto_login"
    resource :plans, only: [:index, :show, :create, :destroy]
    put "plans/:id", to: "plans#update"
    delete "plans/:id", to: "plans#destroy"
    get "plans/:id", to: "plans#show"
  end
end
