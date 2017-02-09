Rails.application.routes.draw do
  namespace :staff do
    root 'top#index'
    get 'login' => 'sessions#new', as: :login
    post 'session' => 'sessions#create', as: :session
    delete 'session' => 'sessions#destroy'
  end

  namespace :admin do
    root 'top#index'
    get 'login' => 'sessions#new', as: :login
    post 'session' => 'sessions#create', as: :session
    delete 'session' => 'sessions#destroy'
    resources :staff_members
    # indexだとadmin/staff_membersでアクセス出来る
    # resources :staff_members, path: 'staff'にするとadmin/staffにアクセスできる
  end

  namespace :customer do
    root 'top#index'
  end

  root 'errors#routing_error'
  # Any get request doesn't exist above will be taken care by here
  get '*anything' => 'errors#routing_error'

end
