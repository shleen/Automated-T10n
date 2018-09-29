Rails.application.routes.draw do
  root 'translations#index'

  post 'translations', to: 'translations#create'
  get 'help', to: 'help#index'
end
