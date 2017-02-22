# 単数リソース => データベースレコードと結びついたリソースのうち、単数のもの。
# 職員 -> アカウントは一つしかないので、単数リソース

Rails.application.routes.draw do
  config = Rails.application.config.baukis

  # 'baukis.example.com'
  constraints host: config[:staff][:host] do
    # /''
    namespace :staff, path: config[:staff][:path] do
      root 'top#index'
      get 'login' => 'sessions#new', as: :login
      resource :session, only: [ :create, :destroy ]
      # Singular resource
      # Baukisには職員自信が自分のアカウントを登録、削除する機能はないので、除外する
      resource :account, except: [ :new, :create, :destroy　]
      resource :password, only: [ :show, :edit, :update ]
    end
  end

  constraints host: config[:admin][:host] do
    # /admin
    namespace :admin, path: config[:admin][:path] do
      root 'top#index'
      get 'login' => 'sessions#new', as: :login
      resource :session, only: [ :create, :destroy ]
      resources :staff_members do
      # indexだとadmin/staff_membersでアクセス出来る
      # resources :staff_members, path: 'staff'にするとadmin/staffにアクセスできる

      # ある特定の職員のログイン・ログアウト操作記録の一覧
      resources :staff_events, only: [ :index ]
      end
      # すべての職員のログイン・ログアウト操作記録の一覧
      resources :staff_events, only: [ :index ]
    end
  end

  constraints host: config[:customer][:host] do
    # /'mypage'
    namespace :customer, path: config[:customer][:path] do
      root 'top#index'
      get 'login' => 'sessions#new', as: :login
      resource :session, only: [ :create, :destroy ]
      resources :customers
    end
  end

  root 'errors#routing_error'
  # Any get request doesn't exist above will be taken care by here
  get '*anything' => 'errors#routing_error'

end
