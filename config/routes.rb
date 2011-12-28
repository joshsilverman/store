OauthClientDemo::Application.routes.draw do
  match '/egg_details/:id' => 'store#egg_details'
  
  # omniauth
  match '/auth/:provider/callback', :to => 'user_sessions#create'
  match '/auth/failure', :to => 'user_sessions#failure'

  # Custom logout
  match '/logout', :to => 'user_sessions#destroy'
  root :to => 'store#index'
end
