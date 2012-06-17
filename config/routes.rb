CustoViagem::Application.routes.draw do
  resources :trips
  root :to => 'trips#new'
  match '*path', :to => 'error#not_found', :only => [:new, :create, :show]
end
