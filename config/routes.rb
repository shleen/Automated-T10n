Rails.application.routes.draw do
  root 'translations#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :translations, only: [:index, :create]
end
