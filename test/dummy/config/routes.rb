Dummy::Application.routes.draw do
  root :to => "artists#index"
  resources :artists
  
  #FIXME Passar isso para um gerador de routes
  post    "publisher/images",                       :to => "publisher/images#create"
  post    "publisher/images/update_sortable",       :to => "publisher/images#update_sortable"
  delete  "publisher/images/:id/:klass/:klass_id",  :to => "publisher/images#destroy"
end
