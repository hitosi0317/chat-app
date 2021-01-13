class RoomUser < ApplicationRecord
  belongs_to :room
  belongs_to :user #どのユーザーがどのチャットルームに参加しているかを管理するのが、中間テーブルである「room_userテーブル」となります。
end
