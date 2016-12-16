Rails.application.routes.draw do

  resources :wikis do
    resources :collaborators, only: [:new, :create, :destroy]
  end

  resources :charges

  get 'welcome/index'

  get 'about' => 'welcome/about'

  root 'welcome#index'

  devise_for :users, controllers: { sessions: 'users/sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
