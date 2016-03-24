Rails.application.routes.draw do
  get 'users/show', path: '/profile'

  devise_for :users
  root 'static_pages#home'
  get  'static_pages/dummy_page'
end
