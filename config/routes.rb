Rails.application.routes.draw do
  root 'translations#index'

  get 'help', to: 'help#index'
end
