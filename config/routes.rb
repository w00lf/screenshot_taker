Rails.application.routes.draw do
  resources :scrapping_tasks, only: %i[new create]
  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'scrapping_tasks#new'
end
