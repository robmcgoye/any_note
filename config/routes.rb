Rails.application.routes.draw do
  devise_for :users, controllers: { 
    registrations: 'users/registrations' 
  }
  
  root 'pages#index'
  pages = %w(about)
  pages.each do |page|
    get "#{page}", to: "pages##{page}"
  end  
  resources :pages, only: [:edit, :update, :show]
  post 'tinymce_assets', to: 'tinymce_assets#create'
  resources :accounts, except: [:index], shallow: true do
    resources :users, except: [:show]
    resources :cabinets, shallow: true do
      resources :folders, shallow: true do
        resources :notes
        resources :subfolders
      end
    end
  end
  
end
