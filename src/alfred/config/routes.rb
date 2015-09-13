Rails.application.routes.draw do
  get 'people/index'
  root 'welcome#index'

  # Google auth
  Rails.application.routes.draw do

    resources :people

    get '/auth/google_oauth2/callback', to: 'google#callback'
    get 'auth/failure', to: redirect('/')
    get 'google/signout'
    get 'google/unregistered'
    get 'google/test'
  end
end
