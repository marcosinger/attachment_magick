Dummy::Application.routes.draw do
  root :to => "artists#index"
  resources :artists
  
  post    "publisher/images",                       :to => "publisher/images#create"
  delete  "publisher/images/:id/:klass/:klass_id",  :to => "publisher/images#destroy"
end
