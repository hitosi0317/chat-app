class Message < ApplicationRecord

  belongs_to :room
  belongs_to :user
  has_one_attached :image #各レコードとファイルを1対1の関係で紐づけるメソッドです。has_one_attachedメソッドを記述したモデルの各レコードは、それぞれ1つのファイルを添付できます。

  validates :content, presence: true, unless: :was_attached?  #Messageモデルに、 validates :content, presence: trueを追記しましょう。#「content」カラムに、presence: trueを設けることで、空の場合はDBに保存しないというバリデーションを設定しています。
  
  def was_attached?
    self.image.attached?
  end
end
#validatesのunlessオプションにメソッド名を指定することで、「メソッドの返り値がfalseならばバリデーションによる検証を行う」という条件を作っています。

#指定されたwas_attached?メソッドは、self.image.attached?という記述によって、画像があればtrue、なければfalseを返す仕組みです。

#これにより、画像が存在しなければテキストが必要となり、画像があればテキストは不要になりました。

