Rails.application.routes.draw do
  devise_for :admins

  resources :products
  resource :cart, only:[:show, :destroy, :update] do
    member do
      post :add, path: 'add/:id'
      post :update_quantity, path: 'update/:id'
      delete :remove, path: 'remove/:id'
      get :checkout
    end
  end

  namespace :admin do
    root 'index#index'
    devise_scope :admin do
      authenticated :admin do
        root 'products#index', as: :authenticated_root
      end
    end

    resources :functions do
    end

    resources :discount_settings do
    end

    resources :costs do
    end

    resources :products do
      collection do
        post   'batch_update'
        delete 'batch_delete'
      end
    end
  end
end
