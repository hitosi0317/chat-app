class Room < ApplicationRecord
  has_many :rooms_users #1つのチャットルームには、2人のユーザーが存在します。
  has_many :users, through: :rooms_users
end
