Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root    'home#index'

  get     '/home/recommend' => 'home#recommend'
  get     '/welcome'  => 'home#welcome'
  get     '/location' => 'home#location'
  get     '/parse_location' => 'home#parse_location'
  get     '/gift_bag' => 'home#gift_bag'
  get     '/sign_up'  => 'registrations#new'
  post    '/sign_up'  => 'registrations#create'
  get     '/sign_in'  => 'sessions#new'
  post    '/sign_in'  => 'sessions#create'
  delete  '/sign_out' => 'sessions#destroy'
  get     '/secret_login/:tel/:key' => 'sessions#secret_login'
  get     '/tel_login' => 'registrations#new_tel'
  post    '/tel_login' => 'registrations#tel_login'
  post    '/set_password' => 'registrations#set_password'

  get     '/mine'     => 'users#mine'

  post    '/send_check_code' => 'registrations#send_check_code'
  get     '/check_mobile' => 'registrations#check_mobile'

  post    '/check_in' => 'users#check_in'

  resources :passwords, only: [:new, :create] do
    collection do
      get   'check_mobile'
      post  'init'
    end
  end

  resources :users, path: 'my', only: [:show] do
    collection do
      get   'info'
      get   'is_limit_buy'
      get   'orders'
      get   'coupons'
      get   'coupons_rule'
      get   'address'
      get   'integral'
      get   'password'
      get   'favorites'
      put   'update_password'
      put   'update_info'
      get   'exchange'
      post  'exchange_coupon'
      #post  'update_integral'
    end
  end



#change by lzh
  delete  'barcode_histories' => 'products#destroy_histories'
# change by lzh

  resources :products, only: [:show, :index] do

    collection do
      get 'list'
      get 'search'

      #change by lzh
      get 'return_product_bycode'
      #change by lzh

      # change by lzh
      get 'return_brand'
      get 'barcode_scanner'
      get 'barcode_histories'
      delete 'destroy_search_histories' => 'products#destroy_search_histories'
      # change by lzh
    end

    member do
      post  'add_favorite'
    end
  end

  resources :common, only: [] do

    collection do
      get 'about'
      get 'after'
      get 'business'
      get 'guide'
      get 'law'
      get 'service'
      get 'mobile_about'
      get 'mobile_agreement'
      get 'registerxy'
      get 'wechat_download'
      get 'invitation_letter'
      get 'join_us'
      get 'contact_us'
      get 'partners'
      get 'reports'
      get 'new_year'
      get 'team'
      get 'way'

      get 'upload_token'
      get 'check_version'

      get 'cities'

      post 'share_page'

      #change by lzh
      get 'return_picture'
      #change by lzh

      get   'generate_code'
      get 'position_infoes'
    end
  end
  get "/reports/:id" => "common#report_content"

  delete  '/carts' => 'carts#destroy_more'
  resources :carts, only: [:index, :create, :destroy] do
    collection do
      get     'brief'
      delete  'destroy_more'
      put     'check_all'
      put     'uncheck_all'

      # change by lzh
      get     'activity_products'
    end

    member do
      put     'update_num'
      put     'check'
      put     'uncheck'
    end
  end

  get   'order_info'  => 'orders#info'
  resources :orders, only: [:index, :show, :create, :destroy] do
    member do
      post  'confirm'
      get   'payment'
      get   'paysuccess'
      get   'stocks'
      post  'buy_again'
      get   'logistics'
      get   'reviews'
      put   'cancel'
    end

    collection do
      get   'buy_speed'
      get   'submit_success'
      post  'pay'
      post  'order_score'
      get   'pay_by_code'
      get   'poundage'
    end
  end

  resources :enshrines, only: [:index, :create, :destroy]

  resources :user_addresses, path: 'addresses', only: [:index, :create, :destroy, :edit, :update, :new] do
    member do
      put 'defadd'
      get 'depot_msg'
      get 'store_edit'
      post 'verify'
    end
    collection do
      get 'provinces'
      get 'cities'
      get 'counties'
      get 'map'
      get 'pcc'

      #
      get 'return_verify_status'
      #
    end
  end

  resources :invitations, only: [:index] do
    collection do
      post  'accept'
    end
  end

  resources :activity, only: [:show] do
    collection do
      get   'rush'
      get   'new_year'
      get   'women_s_day'
      get   'golden_egg'
      get   'golden_egg_screen'
      post  'golden_egg_lottery'
      get   'golden_egg_history'
      get   'anniver_share_page'
      get   'anniver_wechat'
      get   'test'
      get   'points_mall'
      post  'rush_product'
      post  'coupon_lottery'
      post  'coupon_women_day'
      get   'hire2016'
      get   'weishu'
      get   'my_store'
      post  'car_benefit_info'
      post  'survey'
      get   'lottery'
      post  'festival_lottery'
      get   'show_new'
      get   'anniver_wechat'
      get   'anniversary'
      post  'anniversary_lottery'
      get   'point_lottery_item'
      post  'point_lottery_reward'
    end
  end

  resources :mall, only: [:index] do
    member do
      get   'product_detail'
      get   'exchange_detail'
      post  'exchange'
    end

    collection do
      get   'my_point'
      get   'my_exchange'
      get   'product_detail'
      get   'old_lottery'
      get   'lottery'
      get   'lottery_history'

    end
  end

  resources :coupons, only: [:index] do
    collection do
      get   'universal'
      get   'mine'
      get   'sales'
      get   'sales_state'
    end

    member do
      get   'products'
      post  'collect'
      post  'buy'
    end
  end

  resources :notice, only: [:index] do
    collection do
      get   'mine'
      get   'will_dated_coupons'
    end
  end
  resources :popup, only: [:index]

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
