Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
	resources :companies, except:[:new, :edit] do 
    resources :work_notifications, only:[:create,:update,:destroy]
  end

  resources :status_work_notifications,only:[:index,:show,:destroy]

  resources :work_notifications,only:[:index,:show] do
    resources :status_work_notifications, only:[:update]
  end

	resources :candidates, except:[:new, :edit] do
    resources :status_work_notifications, only:[:create]
  end
  
  
  # Defines the root path route ("/")
  # root "articles#index"
end
