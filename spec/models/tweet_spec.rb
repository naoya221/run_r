require 'rails_helper'
describe Tweet do
  before do
    @tweet = FactoryBot.build(:tweet)
  end

  describe '投稿の保存' do
    context "投稿が保存できる場合" do
      it "テキストがあれば保存される" do
        expect(@tweet).to be_valid
      end
    end

    context "投稿が保存できない場合" do
      it "テキストが空だと投稿は保存できない" do
        @tweet.content = ""
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("Content can't be blank")
      end     
      it "ユーザーが紐付いていないと投稿は保存できない" do
        @tweet.user = nil
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("User must exist")
      end
    end
  end
end
