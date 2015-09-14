Rails.application.routes.draw do
    root 'welcome#index'

    resources :people do
      collection do
        get 'me'
      end
    end

    resources :milestones

    # Google auth
    get '/auth/google_oauth2/callback', to: 'google#callback'
    get 'auth/failure', to: redirect('/')
    get 'google/signout'
    get 'google/unregistered'
    get 'google/test'
end