Dummy::Application.routes.draw do
  root :to => "artists#index"
  resources :artists
end
