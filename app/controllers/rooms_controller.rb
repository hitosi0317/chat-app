class RoomsController < ApplicationController
  def new
    @room = Room.new  #チャットルームの新規作成なので「new」アクションを定義します。また、form_withに渡す引数として、値が空のRoomインスタンスを@roomに代入しています
  end
end
