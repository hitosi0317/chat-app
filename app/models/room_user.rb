class RoomUser < ApplicationRecord
  belongs_to :room
  belongs_to :user #どのユーザーがどのチャットルームに参加しているかを管理するのが、中間テーブルである「room_userテーブル」となります。

  validates :name, presence: true #チャットルームを新規作成するにあたって「ルーム名」は必ず必要なので、上記のバリデーションは「ルーム名が存在（presence）している場合のみ作成可（true）」という意味です。
end
