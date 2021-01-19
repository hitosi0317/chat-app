module SignInSupport
  def sign_in(user)
    visit root_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_on("Log in")
    expect(current_path).to eq root_path
  end
end
#このようにsign_inというメソッドを定義することで、spec配下のテストファイルでsign_inメソッドを使用する準備が整いました。

#このspec/supportディレクトリ配下のファイルが、テスト実行時に読み込まれるように設定します。

#rails_helper.rbファイルを開き、記述しましょう。