class RoomsController < ApplicationController

  def index #トップページを表示させる処理
  end

  def new
    @room = Room.new  #チャットルームの新規作成なので「new」アクションを定義します。また、form_withに渡す引数として、値が空のRoomインスタンスを@roomに代入しています
  end

  def create #ここでは、保存が成功したかどうかで処理を分岐しています。 成功した場合はredirect_toメソッドでルートパスにリダイレクトし、 失敗した場合はrenderメソッドでrooms/new.html.erbのページを表示しています。
    @room = Room.new(room_params)
    if @room.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy #次に、roomsコントローラーにdestroyアクションを定義します。どのチャットルームを削除するのかを特定する場合は、Room.find(params[:id])を使用して、削除したいチャットルームの情報を取得します。destroyアクションは、削除するだけなのでビューの表示は必要はありません。 そのため、インスタンス変数ではなく変数としてroomを定義し、destroyメソッドを使用します。destroyメソッドが実行されたら、root（roomsのindex）にリダイレクトする記述をします。
    room = Room.find(params[:id])
    room.destroy
    redirect_to root_path
  end

  private

  def room_params
    params.require(:room).permit(:name, user_ids:[])
  end
end