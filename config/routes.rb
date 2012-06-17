CustoViagem::Application.routes.draw do
  resources :trips, :only => [:new, :create, :show]
  root :to => 'trips#new'
  match '*path', :to => 'error#not_found'
end
