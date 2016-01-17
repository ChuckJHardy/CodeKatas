Rails.application.routes.draw do
  resources :users, only: [] do
    resources :posts, only: [:index, :create, :destroy]
  end
end
