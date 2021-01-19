FactoryBot.define do
  factory :room_user do
    association :user
    association :room
  end
end

#associationメソッドは、RSpecのレッスンでも登場した、FactoryBotによって生成されるモデルを関連づけるメソッドです。
#中間テーブルのテスト用モデルにアソシエーションが定義できました。