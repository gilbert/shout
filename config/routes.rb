Rails.application.routes.draw do

  get 'admin' => 'admin#new'
  delete 'admin/sign-out' => 'admin#sign_out', :as => :sign_out
  resource :admin, :controller => 'admin', :only => [:create, :destroy]

  resources :links, :only => [:new, :create, :show]
  get '*path', to: 'links#show'

  root 'links#new'
end
