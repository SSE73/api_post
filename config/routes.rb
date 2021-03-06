Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      defaults format: :json do
        resources :posts, except: [:edit,:new]
      end
    end
  end
end
