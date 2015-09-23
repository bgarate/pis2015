Rails.application.routes.draw do

  root to: 'people#me'

  get 'welcome/index'

  resources :people do
    post :assign_milestone
    collection do
      get 'me'
    end
  end

  resources :projects do
  end

  #hitos
  resources :milestones do
    resources :notes
    post :add_category
  end
  get 'milestones/markasdone'

  resources :categories do
    resources :milestones
  end

  # Google auth
  get '/auth/google_oauth2/callback', to: 'google#callback'
  get 'auth/failure', to: redirect('/')
  get 'google/signout'
  get 'google/unregistered'
  get 'google/test'

end