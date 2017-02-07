Rails.application.routes.draw do
  namespace :staff do
    root 'top#index'
    get 'login' => 'sessions#new', as: :login
    put 'session' => 'sessions#create', as: :session
    delete 'logout' => 'sessions#destroy'
  end

  namespace :admin do
    root 'top#index'
  end

  namespace :customer do
    root 'top#index'
  end

  root 'errors#routing_error'
  # Any get request doesn't exist above will be taken care by here
  get '*anything' => 'errors#routing_error'

end
