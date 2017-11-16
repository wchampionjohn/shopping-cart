Rails.application.routes.draw do
  devise_for :admins

  resources :products

  namespace :admin do
    root 'index#index'
    devise_scope :admin do
      authenticated :admin do
        root 'products#index', as: :authenticated_root
      end
    end

    resources :products do
      collection do
        post   'batch_update'
        delete 'batch_delete'
      end
    end
  end
end
