Rails.application.routes.draw do
  get 'chirps/timeline', path: '/timeline'
  resources :chirps, shallow: true do
    collection do
      get :timeline # path: '/timeline'
    end
  end
  resources :trade_logs
  resources :blogs do
    resources :comments
  end
  resources :comments, only: [:edit, :show, :destroy]
  get 'blogs/public_blog', path: '/blog'
  get 'users/my_profile', path: '/my_profile'
  get 'users/profile/:id', to: 'users#show', as: '/profile'

  devise_for :users
  root 'static_pages#home'
  get  'static_pages/dummy_page'
end
