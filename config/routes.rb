Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'pets#index'
  resources :pets

  get 'users', to: 'users#index'
  delete 'users/:id', to: 'users#destroy'
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  post 'logout', to: 'users#logout'
  get 'vet_index', to: 'vet_registrations#vet_index'
  get 'vet_registrations_index', to: 'vet_registrations#vet_index'
  get 'vet_pets_index', to: 'pets#vet_index'
  get 'vet_appointments_index', to: 'appointments#vet_index'
  resources :vet_registrations
  resources :appointments

end
