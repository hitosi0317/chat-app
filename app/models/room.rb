class Room < ApplicationRecord
  #MessageモデルとRoomUserモデルにdependent: :destroyを記述します。
  #dependentオプションに:destroyを指定した場合、Room（親モデル）が削除されたときに、関連付けしているMessage（子モデル）とRoomUser（子モデル）も削除されます。
  #これで、roomを削除したとき、roomに関連するmessagesテーブルのレコードとroom_usersテーブルのレコードも、一緒に削除されるように設定できました。
  has_many :room_users, dependent: :destroy#1つのチャットルームには、2人のユーザーが存在します。
  has_many :users, through: :room_users
  has_many :messages, dependent: :destroy
  validates :name, presence: true #チャットルームを新規作成するにあたって「ルーム名」は必ず必要なので、上記のバリデーションは「ルーム名が存在（presence）している場合のみ作成可（true）」という意味です。

end
