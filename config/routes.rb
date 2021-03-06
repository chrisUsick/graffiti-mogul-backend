Rails.application.routes.draw do
  post 'tags/create'

  get 'tags/find'

  get 'tags/:id', to: 'tags#show'

  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/auth/mobile', to: 'mobile_auth#sign_in'
  get '/dev/auth_token', file: 'index.html'
end
