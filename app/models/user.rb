class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

has_many :room_users #1人のユーザーは複数のチャットルームに参加出来ます。
has_many :rooms, through: :room_users
end
