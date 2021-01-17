require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = FactoryBot.build(:message)
  end

  it 'contentとimageが存在していれば保存できること' do
    expect(@message).to be_valid#contentとimageの両方が存在していれば、DBに正しく保存されるかを確認しています。
  end

  it 'contentがからでも保存できること'do
    @message.content = nil #contentが空でも（imageが存在していれば）、DBに正しく保存されるかを確認しています。
    expect(@message).to be_valid
  end

  it 'imageが空でも保存できること' do
    @message.image = nil
    expect(@message).to be_valid
  end

  it 'contentとimageが空では保存できないこと' do
    @message.content = nil
    @message.image = nil
    @message.valid?
    expect(@message.errors.full_messages).to include("Content can't be blank")
  end

  it 'roomが紐づいていないと保存できないこと' do
    @message.room = nil#アソシエーションによって@messageに紐づいているroomを空にした上で、32行目でバリデーションを確認しています。エラーメッセージはRoom must existです
    @message.valid?
    expect(@message.errors.full_messages).to include("Room must exist")
  end
  
  it 'userが紐づいていないと保存できないこと' do
    @message.user = nil
    @message.valid?
    expect(@message.errors.full_messages).to include("User must exist")
  end
end
