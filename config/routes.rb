# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  root 'home#index'
  resources :upload_files, only: [:create, :show]
end
