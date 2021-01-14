class Message < ApplicationRecord

  belongs_to :room
  belongs_to :user

  validates :content, presence: true  #Messageモデルに、 validates :content, presence: trueを追記しましょう。#「content」カラムに、presence: trueを設けることで、空の場合はDBに保存しないというバリデーションを設定しています。
  
end
