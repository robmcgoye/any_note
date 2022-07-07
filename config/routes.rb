Rails.application.routes.draw do
  # resources :notes
  devise_for :users, controllers: { 
    registrations: 'users/registrations' 
  }
  resources :cabinets
  root 'pages#index'
  pages = %w(about)
  pages.each do |page|
    get "#{page}", to: "pages##{page}"
  end  
  resources :pages, only: [:edit, :update, :show]
  post 'tinymce_assets', to: 'tinymce_assets#create'
  # get 'sign_up', to: "accounts#new"
  # post 'sign_up', to: 'accounts#create'
  resources :accounts, except: [:index], shallow: true do
    resources :users, except: [:show]
  end
  
end
