Dummy::Application.routes.draw do


  delete 'attachment_magick/images/:id/:data_attachment',  :to => 'attachment_magick/images#destroy'

  post 'attachment_magick/images/update_sortable', :to => 'attachment_magick/images#update_sortable'

  post 'attachment_magick/images', :to => 'attachment_magick/images#create'

  root :to => "artists#index"
  resources :artists
end
