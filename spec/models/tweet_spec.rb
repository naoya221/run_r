require 'rails_helper'
describe Tweet do
  before do
    @tweet = FactoryBot.build(:tweet)
    @tweet.place_image = fixture_file_upload("public/images/place_image.png")
  end

  describe '投稿の保存' do
    context "投稿が保存できる場合" do
      it "全てのフォームに情報が入力されていれば投稿できる" do
        expect(@tweet).to be_valid
      end
      it "緯度がなくても投稿できる" do
        @tweet.latitude = ""
        expect(@tweet).to be_valid
      end
      it "経度がなくても投稿できる" do
        @tweet.longitude = ""
        expect(@tweet).to be_valid
      end
    end

    context "投稿が保存できない場合" do
      it "場所の名前が空だと投稿は保存できない" do
        @tweet.place_name = ""
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("場所の名前を入力してください")
      end  
      it "場所の画像が空だと投稿は保存できない" do
        @tweet.place_image = ""
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("場所の画像を入力してください")
      end  
      it "住所が空だと投稿は保存できない" do
        @tweet.address = ""
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("住所を入力してください")
      end  
      it "何かひとことが空だと投稿は保存できない" do
        @tweet.content = ""
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("　何かひとことを入力してください")
      end     
      it "ユーザーが紐付いていないと投稿は保存できない" do
        @tweet.user = nil
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end
