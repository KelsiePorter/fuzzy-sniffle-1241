Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #dishes
  get '/dishes/:id', to: 'dishes#show'

  #dish_ingredients
  post '/dishes/:dish_id/ingredients', to: 'dish_ingredients#create'

  #chefs
  get '/chefs/:chef_id/ingredients', to: 'chef_ingredients#index'
  get '/chefs/:id', to: 'chefs#show'
  patch '/chefs/:id', to: 'chefs#update'
end
