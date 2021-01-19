require 'rails_helper'

RSpec.describe "Messages", type: :system do
  before do
    @room_user = FactoryBot.create(:room_user)
  end
  # 中間テーブルを作成して、associationによりusersテーブルとroomsテーブルのレコードも作成する
  #中間テーブルのレコード及びそこに紐づいているuserとroomのレコードを生成できます。

  context '投稿に失敗した時'
    it '送る値が空のため、メッセージの送信に失敗すること' do
      # サインインする  @room_userに紐づくuserが生成されているため、@room_user.userというアソシエーションの記述で取得できる
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する  。roomについても上と同様。最終的にnameカラムの値を取得しclick_onメソッドの引数にして、チャットルームの名前のリンクをクリックしている
      click_on(@room_user.room.name)
      
      # DBに保存されていないことを確認する
       expect {find('input[name="commit"]').click}.not_to change {Message.count}
      # 元のページに戻ってくることを確認する
       expect(current_path).to eq room_messages_path(@room_user.room)
    end

    context '投稿に成功した時' do
      it 'テキストの投稿に成功すると、投稿一覧に遷移して、投稿した内容が表示されている' do
        # サインインする    # サインインする。@room_userに紐づくuserが生成されているため、@room_user.userというアソシエーションの記述で取得できる
        sign_in(@room_user.user)

        # 作成されたチャットルームへ遷移する 。roomについても上と同様。最終的にnameカラムの値を取得しclick_onメソッドの引数にして、チャットルームの名前のリンクをクリックしている
        click_on(@room_user.room.name)

        # 値をテキストフォームに入力する
        post = "テスト" #変数postに「テスト」という文字列を代入します。ここで変数に代入するのは、この後の工程で再度この文字列を使用するからです。fill_inメソッドを使って、変数postの内容をフォームに入力します。
        fill_in 'message_content', with: post
        # 送信した値がDBに保存されていることを確認する  送信ボタンをクリックしたときに、messageモデルのレコードが1つ増えているかを確認しています。
        expect {find('input[name="commit"]').click}.to change {Message.count}.by(1)
        # 投稿一覧画面に遷移していることを確認する
        expect(current_path).to eq room_messages_path(@room_user.room)
        # 送信した値がブラウザに表示されていることを確認する #投稿後にメッセージ一覧画面に遷移していることを確認したあと、expect(page).to have_content(post)で、一覧画面の中に変数postに格納されている文字列があるかどうかを確認しています。
        expect(page).to have_content(post)
    end

    it '画像の投稿に成功すると、投稿一覧に遷移して、投稿した画像が表示されている' do
      #サインインする
      sign_in(@room_user.user)

      # 作成されたチャットルームへ遷移する #添付する画像を定義して、「image_path」に代入します
      click_on(@room_user.room.name)
      #添付する画像を定義する
      image_path = Rails.root.join('public/images/test_image.png')

      # 画像選択フォーム二画像を添付する attach_fileメソッドを 使用して、画像をアップロードします。make_visible: trueを付けることで非表示になっている要素も一時的に hidden でない状態になります。
      attach_file('message[image]', image_path, make_visible: true)
      # 送信した値がDBに保存されていることを確認する
      expect {find('input[name="commit"]').click}.to change { Message.count }.by(1)
      # 送信一覧画面に遷移していることを確認する # 投稿後は、チャットルーム画面に遷移していることを確認します
      expect(current_path).to eq room_messages_path(@room_user.room)
      # 送信した画像がブラウザに表示されていることを確認する #最後に、投稿した画像が一覧表示されているかをhave_selectorで取得して、確認しています。
      expect(page).to  have_selector("img")
    end

    it 'テキストと画像の投稿に成功すること' do
      # サインインする
        sign_in(@room_user.user)
      # 作成されたチャットルームへ遷移する
        click_on(@room_user.room.name)

      #添付する画像を定義する
        image_path =Rails.root.join('public/images/test_image.png')

      # 画像選択フォームに画像を添付する
        attach_file('message[image]', image_path, make_visible: true)
      # 値をテキストフォームに入力する
        post = "テスト"
        fill_in 'message_content', with: post
      # 送信した値がDBに保存されていることを確認する
        expect {find('input[name="commit"]').click}.to change { Message.count }.by(1)
      # 送信した値がブラウザに表示されていることを確認する
        expect(page).to have_content(post)
      # 送信した画像がブラウザに表示されていることを確認する
        expect(page).to have_selector("img")
      #ChatAppでは、投稿が完了すると、メッセージ一覧へリダイレクトされます。しかし、今回のテストコードでは、投稿を行った後にメッセージ一覧のページいることは、current_pathなどで確認していません。なぜならば、投稿したメッセージと画像をhave_selectorで確認することで、一覧表示画面に遷移出来ているかどうかが確認できるためでsu
    end
  end
end
