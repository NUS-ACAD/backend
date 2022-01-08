Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
#   resources :feeds, :follows, :invites, :likes, :members, :mods, :plans, :semesters, :users
  scope "/api" do
    resource :users, only: [:create]
    post "login", to: "users#login"
    get "auto_login", to: "users#auto_login"
    resource :plans, only: [:create]
    get "invites", to: "invites#index"
    get "invites/:id", to: "invites#get_invites_for_user"
    post "invites", to: "invites#create"
    delete "invites/:id", to: "invites#destroy"
    patch "invites/:id", to: "invites#update"
    get "follows", to: "follows#index"
    post "follows", to: "follows#create"
    get "likes", to: "likes#index"
    post "likes", to: "likes#create"
    get "groups", to: "groups#index"
    get "groups/:id", to: "groups#show"
    post "groups", to: "groups#create"
    patch "groups/:id", to: "groups#update"
    delete "groups/:id", to: "groups#destroy"
    post "groups/:id/leave", to: "groups#leave"
    get "users/:id", to: "users#index"
    patch "plans/:id", to: "plans#update"
    delete "plans/:id", to: "plans#destroy"
    get "plans/:id", to: "plans#show"
    post "plans/fork/:id", to: "plans#fork"
    get "/home", to: "home#index"
  end
end
