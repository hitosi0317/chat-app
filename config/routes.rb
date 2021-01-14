Rails.application.routes.draw do
  devise_for :users
  root to: "rooms#index"                   #トップページを表示セルルーティング                                                                                                                                       
  resources :users, only: [:edit, :update] #ユーザー編集に必要なルーティングは、editとupdateなので、ユーザー編集に必要なルーティングは、editとupdate                                                           
  resources :rooms, only: [:new, :create]

end
