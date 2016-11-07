Rails.application.routes.draw do
  

  resources :suppliers do
    resources :supply_product_infos, shallow: true
  end


  resources :distributors do
    resources :distri_product_infos, shallow: true
  end

  resources :consumer_infos
  resources :vehicleinfos
  resources :cash_purchases
  get 'dashboards/index' => 'dashboards#index'
  get 'dashboards/no_permission' => 'dashboards#no_permission'

  resources :roles

  resources :userinfos do
    post 'jyd_check/:userinfo_id', to: "userinfos#jyd_check", :on => :collection
    post 'jyd_check_out/:userinfo_id', to: "userinfos#jyd_check_out", :on => :collection
    delete 'jyd_destroy/:userinfo_id', to: "userinfos#jyd_destroy", :on => :collection

    #单位角色分配
    get 'jyd_roles_form/:userinfo_id', to: "userinfos#jyd_roles_form", :on => :collection
    post 'jyd_roles_set', to: "userinfos#jyd_roles_set", :on => :collection
    get 'initialize_jxc/:userinfo_id', to: "userinfos#initialize_jxc", :on => :collection

  end

  devise_for :users, controllers: {
                       sessions: 'users/sessions',
                       registrations: 'users/registrations', #-----addby <dfj>
                   }

  devise_scope :user do
    get "users/sessions/password_reset", to: "users/sessions#password_reset"
    get "users/sessions/cheak_mobile", to: "users/sessions#cheak_mobile"
    get "users/send_message", to: "users/registrations#send_message"
    post "users/sessions/fix_password", to: "users/sessions#fix_password"
    post "users/mobile_sign_in", to: "users/mobile_sessions#create"
    post "users/mobile_sign_out", to: "users/mobile_sessions#destroy"
  end

  root to: "root#index"

  namespace :admin do
    post 'users/upload'
    resources :users
    post 'users/manage_store'
    get 'users/:id/reset_password' => 'users#reset_password'
    get 'users/:id/modify_loginpasswordForm' => 'users#modify_loginpasswordForm'
    post 'users/modify_loginpassword' => 'users#modify_loginpassword'
  end

end
