CustoViagem::Application.routes.draw do
  resources :trips
  root :to => 'trips#show'
  match '*path', :to => 'error#not_found'
end
