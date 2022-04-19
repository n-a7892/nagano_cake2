Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  devise_for :customer,skip:[:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  namespace :admin do
    resources :orders, only: [:show, :update]
  end

  namespace :admin do
    resources :order_details, only: [:update]
  end

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
  end

  namespace :admin do
    resources :genres, only: [:index, :edit, :create, :update]
  end

  namespace :admin do
    resources :items, only: [:new, :index, :show, :edit, :create, :update]
  end

  namespace :admin do
    root to: 'homes#top'
  end

  namespace :public do
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  namespace :public do
    get 'orders/complete'
    post 'orders/comfirm'
    resources :orders, only: [:new, :index, :show, :create]
  end

  namespace :public do
    delete 'cart_items/destroy_all'
    resources :cart_items, only: [:index, :update, :destroy, :create]
  end

  namespace :public do
    get 'customers/out'
    get "customers/my_page" =>"customers#show", as: "my_page"
    patch 'customers/withdraw'
    resource :customers, only: [:show, :edit, :update]
  end

  namespace :public do
    resources :items, only: [:index, :show]
  end

  # namespace :public do
    get "/about" => "public/homes#about", as: "about"
  # end

  root to: 'public/homes#top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
