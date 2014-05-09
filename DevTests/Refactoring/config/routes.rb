RefactoringChallenge::Application.routes.draw do
  resources :events, only: [:index]
end
