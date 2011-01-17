Dummy::Application.routes.draw do

  delete 'publisher/images/:id/:klass/:klass_id',   :to => 'publisher/images#destroy'
  post 'publisher/images/update_sortable',          :to => 'publisher/images#update_sortable'
  post 'publisher/images',                          :to => 'publisher/images#create'

  root :to => "artists#index"
  resources :artists
end
