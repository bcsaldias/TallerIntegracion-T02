Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	#resources :users, path: :usuario
	
	get 'usuario' => 'users#index'
    put 'usuario' => 'users#create'
    get 'usuario/:id' => 'users#show'
    post 'usuario/:id' => 'users#update'
    delete 'usuario/:id' => 'users#destroy'
    

end
