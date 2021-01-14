class MessagesController < ApplicationController
  def index
    @message = Message.new #@messageには、Message.newで生成した、Messageモデルのインスタンス情報を代入します。
    @room = Room.find(params[:room_id]) #@roomには、Room.find(params[:room_id])と記述することで、paramsに含まれているroom_idを代入します。 紐解いて説明すると、直前の問題にあった通りルーティングをネストしているため/rooms/:room_id/messagesといったパスになります。 パスにroom_idが含まれているため、paramsというハッシュオブジェクトの中に、room_idという値が存在しています。そのため、params[:room_id]と記述することでroom_idを取得できます。
   
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.save#createアクション内に、メッセージを保存できた場合とできなかった場合で条件分岐の処理を行います。@message.saveでメッセージの保存に成功した場合、redirect_toメソッドを用いてmessagesコントローラーのindexアクションに再度リクエストを送信し、新たにインスタンス変数を生成します。これによって保存後の情報に更新されます。メッセージの保存に失敗した場合、renderメソッドを用いてindexアクションのindex.html.erbを表示するように指定しています。このとき、indexアクションのインスタンス変数はそのままindex.html.erbに渡され、同じページに戻ります。
      redirect_to room_messages_path(@room)
    else
      render :index
    end
  end  #messagesコントローラーにcreateアクションを定義します。でチャットルームに紐づいたメッセージのインスタンスを生成し、message_paramsを引数にして、privateメソッドを呼び出します。その値を@messageに代入し、saveメソッドでメッセージの内容をmessagesテーブルに保存します。
    
  
  private

  def message_params#privateメソッドとしてmessage_paramsを定義し、メッセージの内容(content)をmessagesテーブルへ保存できるようにします。パラメーターの中に、ログインしているユーザーのidと紐付いている、メッセージの内容(content)を受け取れるように許可します。
    params.require(:message).permit(:content).merge(user_id: current_user.id)
  end
end