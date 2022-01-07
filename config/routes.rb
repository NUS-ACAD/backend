Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :feeds, :follows, :invites, :likes, :members, :mods, :plans, :semesters, :users
end
