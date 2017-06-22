Rails.application.routes.draw do


    resources :users
    resource :session, :only => [:create], :controller => 'session'

    match 'logout' => "session#destroy" ,via: :all
    match 'login' => "session#new" , via: :all

    match'setup'=>"setups#show",via: :all

  end
