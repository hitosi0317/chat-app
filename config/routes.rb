Rails.application.routes.draw do
  devise_for :users
  root to: "rooms#index"                   #トップページを表示セルルーティング                                                                                                                                       
  resources :users, only: [:edit, :update] #ユーザー編集に必要なルーティングは、editとupdateなので、ユーザー編集に必要なルーティングは、editとupdate                                                           
  resources :rooms, only: [:new, :create] do
    resources :messages, only: [:index, :create] #今回の場合、ネストをすることにより、roomsが親で、messagesが子という親子関係になるので、チャットルームに属しているメッセージという意味になります。これによって、メッセージに結びつくルームのidの情報を含んだパスを、受け取れるようになります。
  end

end
