class MessagesController < ApplicationController
  def index
    @message = Message.new #@messageには、Message.newで生成した、Messageモデルのインスタンス情報を代入します。
    @room = Room.find(params[:room_id]) #@roomには、Room.find(params[:room_id])と記述することで、paramsに含まれているroom_idを代入します。 紐解いて説明すると、直前の問題にあった通りルーティングをネストしているため/rooms/:room_id/messagesといったパスになります。 パスにroom_idが含まれているため、paramsというハッシュオブジェクトの中に、room_idという値が存在しています。そのため、params[:room_id]と記述することでroom_idを取得できます。
    @messages = @room.messages.includes(:user) #一覧画面で表示するメッセージ情報を取得するチャットルームに紐付いている全てのメッセージ（@room.messages）を@messagesと定義します。 そして、一覧画面で表示するメッセージ情報には、ユーザー情報も紐付いて表示されます。この場合、メッセージに紐付くユーザー情報の取得に、メッセージの数と同じ回数のアクセスが必要になるので、N+1問題が発生します。その場合は、includesメソッドを使用して、解消しましょう。全てのメッセージ情報に紐づくユーザー情報を、includes(:user)と記述をすることにより、ユーザー情報を1度のアクセスでまとめて取得することができます。
    
    
    
    
   
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.save#createアクション内に、メッセージを保存できた場合とできなかった場合で条件分岐の処理を行います。@message.saveでメッセージの保存に成功した場合、redirect_toメソッドを用いてmessagesコントローラーのindexアクションに再度リクエストを送信し、新たにインスタンス変数を生成します。これによって保存後の情報に更新されます。メッセージの保存に失敗した場合、renderメソッドを用いてindexアクションのindex.html.erbを表示するように指定しています。このとき、indexアクションのインスタンス変数はそのままindex.html.erbに渡され、同じページに戻ります。
      redirect_to room_messages_path(@room)
    else
      @messages = @room.messages.includes(:user) #一覧画面で表示するメッセージ情報を取得するまた、投稿に失敗したときの処理にも、同様に@messagesを定義しました。renderを用いることで、投稿に失敗した@messageの情報を保持しつつindex.html.erbを参照することができます（この時、indexアクションは経由しません）。しかしながら、そのときに@messagesが定義されていないとエラーになってしまいます。そこで、indexアクションと同様に@messagesを定義する必要があります。
      render :index
    end
  end  #messagesコントローラーにcreateアクションを定義します。でチャットルームに紐づいたメッセージのインスタンスを生成し、message_paramsを引数にして、privateメソッドを呼び出します。その値を@messageに代入し、saveメソッドでメッセージの内容をmessagesテーブルに保存します。
    
  
  private

  def message_params#privateメソッドとしてmessage_paramsを定義し、メッセージの内容(content)をmessagesテーブルへ保存できるようにします。パラメーターの中に、ログインしているユーザーのidと紐付いている、メッセージの内容(content)を受け取れるように許可します。
    params.require(:message).permit(:content).merge(user_id: current_user.id)
  end
end