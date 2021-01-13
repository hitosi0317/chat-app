class UsersController < ApplicationController
  def edit #users_controller.rbに、editアクションを定義します。
    # editアクションでは、ビューファイルを表示するだけなので、アクションの定義のみになります。
  end

  def update #Userモデルの更新を行うupdateアクションをusersコントローラーに定義しましょう。
    if current_user.update(user_params)#current_user.updateに成功した場合、root（チャット画面）にリダイレクトします
      redirect_to root_path
    else #失敗した場合、render :editとeditのアクションを指定しているため、editのビューが表示されます。
      render :edit
    end
  end #そして、ユーザー情報が格納されているcurrent_userメソッドを使用して、ログインしているユーザーの情報を更新します。

  private

  def user_params #ストロングパラメーターを使用し、user_paramsを定義します。
    params.require(:user).permit(:name, :email)
  end #user_paramsの中でpermitメソッドを使用し、「name」と「email」の編集を許可します。
  
  
  
end
