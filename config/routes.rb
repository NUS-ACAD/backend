Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
#   resources :feeds, :follows, :invites, :likes, :members, :mods, :plans, :semesters, :users
  scope "/api" do
    resource :users, only: [:create]
    post "login", to: "users#login"
    get "auto_login", to: "users#auto_login"
    get "invites", to: "invites#index"
    post "invites", to: "invites#create"
    delete "invites/:id", to: "invites#destroy"
    patch "invites/:id", to: "invites#update"
    get "follows", to: "follows#index"
    post "follows", to: "follows#create"
    get "likes", to: "likes#index"
    post "likes", to: "likes#create"
    post "groups/:id/leave", to: "groups#leave"
    post "groups", to: "groups#create"
    patch "groups", to: "groups#update"
    delete "groups", to: "groups#destroy"
  end
end
