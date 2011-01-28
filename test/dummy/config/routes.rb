Dummy::Application.routes.draw do


  delete 'publisher/images/:id/:data_attachment',  :to => 'publisher/images#destroy'

  post 'publisher/images/update_sortable', :to => 'publisher/images#update_sortable'

  post 'publisher/images', :to => 'publisher/images#create'

  root :to => "artists#index"
  resources :artists
end
