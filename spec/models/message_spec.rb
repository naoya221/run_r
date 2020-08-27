require 'rails_helper'
describe Message do
  before do
    @message = FactoryBot.build(:message)
  end

  describe 'コメントの保存' do
    context "コメントが保存できる場合" do
      it "テキストがあれば保存される" do
        expect(@message).to be_valid
      end
    end

    context "コメントが保存できない場合" do
      it "テキストが空だとコメントは保存できない" do
        @message.text = ""
        @message.valid?
        expect(@message.errors.full_messages).to include("Text can't be blank")
      end     
      it "ユーザーが紐付いていないとコメントは保存できない" do
        @message.user = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("User must exist")
      end
      it "コメントされている投稿が紐付いていないとコメントは保存できない" do
        @message.tweet = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("Tweet must exist")
      end
    end
  end
end
