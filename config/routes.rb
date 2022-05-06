Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
	resources :companies, except:[:new, :edit] do 
    resources :work_notifications, only:[:create,:update,:destroy]
  end

  resources :work_notifications,only:[:index,:show]
  post '/companies/:company_id/work_notifications/:id/apply', to: 'work_notifications#apply'
  put '/companies/:company_id/work_notifications/:id/apply/:status_id', to: 'work_notifications#applyupdate'

	resources :candidates, except:[:new, :edit]
  
  
  # Defines the root path route ("/")
  # root "articles#index"
end
