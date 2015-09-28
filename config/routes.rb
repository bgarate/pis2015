Rails.application.routes.draw do

  root to: 'people#me'

  get 'welcome/index'

  resources :people do
    post :assign_milestone
    collection do
      get 'me'
      post 'add_mentor'
      get 'add_mentor_form'
    end
  end

  resources :projects do
  end

  resources :tags

  #hitos
  resources :milestones do
    resources :notes
    post :add_category
    get :set_as_done
  end

  resources :categories do
    resources :milestones
  end

  # Google auth
  get '/auth/google_oauth2/callback', to: 'google#callback'
  get 'auth/failure', to: redirect('/')
  get 'google/signout'
  get 'google/unregistered'
  #google drive
  get 'google/adddriveview'
  get 'google/adddrive'
  get 'google/driveerror'

end