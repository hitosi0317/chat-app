require 'rails_helper'

RSpec.describe "ユーザーログイン機能", type: :system do
    it 'ログインしていない状態でトップページにアクセスした場合、サインインページに移動する' do
      #トップページに遷移する
      visit root_path
      #ログインしていない場合、サインインページに遷移していることを確認する
      expect(current_path).to eq new_user_session_path#まず、データベースにcreateメソッドでユーザーをテスト用のDBに保存します。保存したユーザーで、この後ログインを行います。
    end

    it 'ログインに成功しトップページに遷移する' do
      # 予め、ユーザーをDBに保存する
        @user = FactoryBot.create(:user)
      # サインインページへ移動する
        visit new_user_session_path
      # ログインしていない場合、サインインページに遷移していることを確認する
        expect(current_path).to eq new_user_session_path#保存したユーザーは、ログインを行っていないので、ログイン画面に遷移します。
      # すでに保存されているゆーざーのemailとpasswordを入力する
        fill_in 'user_email', with: @user.email#保存したユーザーの「メールアドレス」「パスワード」をfill_inメソッドで入力を行います。入力後に、click_onメソッドで「Log in」をクリックしてログインをします。
        fill_in 'user_password', with: @user.password
      # ログインボタンをクリックする
        click_on("Log in")
      # トップページに遷移していることを確認する
        expect(current_path).to eq root_path#ログインが成功した場合は、トップページに遷移します。 expectメソッドを用いて、ログインページ（current_path）から、トップページ（root_path）に遷移していることを確認しています。
            
    end

    it 'ログインに失敗し、再びサインインページに戻ってくる' do
      
      # 予め、ゆーざーをDBに保存する
       @user = FactoryBot.create(:user)
      # トップページに遷移する
       visit root_path
      # ログインしていない場合、サインインページに遷移していることを確認する
        expect(current_path).to eq new_user_session_path
      # 誤ったユーザー情報を入力する
        fill_in 'user_email', with: "aaaaa"
        fill_in 'user_password', with: "aaaa"
      # ログインボタンをクリックする
        click_on("Log in")
      # サインインページにも戻ってきていることを確認する
        expect(current_path).to eq new_user_session_path
    end
end
