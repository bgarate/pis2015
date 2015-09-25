Rails.application.routes.draw do

  root to: "people#me"

  get 'welcome/index'

  resources :people do
    collection do
      get 'me'
      post 'add_mentor'
      get 'add_mentor_form'
    end
  end

  resources :projects do
  end

  #hitos
  resources :milestones
  get 'milestones/markasdone'

  # Google auth
  get '/auth/google_oauth2/callback', to: 'google#callback'
  get 'auth/failure', to: redirect('/')
  get 'google/signout'
  get 'google/signout'
  get 'google/unregistered'
  #google drive
  get 'google/adddriveview'
  get 'google/adddrive'
  get 'google/driveerror'

end