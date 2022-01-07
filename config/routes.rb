Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
<<<<<<< HEAD
#   resources :feeds, :follows, :invites, :likes, :members, :mods, :plans, :semesters, :users
  scope "/api" do
    resource :users, only: [:create]
    post "login", to: "users#login"
    get "auto_login", to: "users#auto_login"
  end
=======
  resources :feeds, :follows, :invites, :likes, :members, :mods, :plans, :semesters, :users
>>>>>>> 3f29ab899cb856f4c19ac7d548b86f68d0d238a1
end
