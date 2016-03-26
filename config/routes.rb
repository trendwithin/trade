Rails.application.routes.draw do
  resources :blogs
  get 'blogs/public_blog', path: '/blog'
  get 'users/show', path: '/profile'

  devise_for :users
  root 'static_pages#home'
  get  'static_pages/dummy_page'
end
