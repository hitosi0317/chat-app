class Room < ApplicationRecord
  has_many :room_users #1つのチャットルームには、2人のユーザーが存在します。
  has_many :users, through: :room_users
end
