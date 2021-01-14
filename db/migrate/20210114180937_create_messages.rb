class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string  :content #テキストの内容：「content」カラム
      t.references :room, foreign_key: true #メッセージの投稿をしたチャットルームのid：「room_id」カラム
      t.references :user, foreign_key: true #メッセージの投稿をしたユーザーのid：「user_id」カラム
      #roomとuserには、foreign_key: trueの制約をつけましょう。こちらの制約をつけることにより、外部キー（今回であればroom_idとuser_id）がないとDBに保存できないようにします。
      t.timestamps
    end
  end
end
