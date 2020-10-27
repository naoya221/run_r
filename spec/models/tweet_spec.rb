require 'rails_helper'
describe Tweet do
  before do
    @tweet = FactoryBot.build(:tweet)
    @tweet.place_image = fixture_file_upload('public/images/place_image.png')
  end

  describe '投稿の保存' do
    context '投稿が保存できる場合' do
      it '全てのフォーム（タグ以外）に情報が入力されていれば投稿できる' do
        expect(@tweet).to be_valid
      end
      it '緯度がなくても投稿できる' do
        @tweet.latitude = ''
        expect(@tweet).to be_valid
      end
      it '経度がなくても投稿できる' do
        @tweet.longitude = ''
        expect(@tweet).to be_valid
      end
    end

    context '投稿が保存できない場合' do
      it '場所の名前が空だと投稿は保存できない' do
        @tweet.place_name = ''
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include('場所の名前を入力してください')
      end
      it '場所の名前が17文字以上だと投稿は保存できない' do
        @tweet.place_name = 'a' * 17
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include('場所の名前は16文字以内で入力してください')
      end
      it '場所の画像が空だと投稿は保存できない' do
        @tweet.place_image = ''
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include('場所の画像を入力してください')
      end
      it '住所が空だと投稿は保存できない' do
        @tweet.address = ''
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include('住所を入力してください')
      end
      it '住所が31文字以上だと投稿は保存できない' do
        @tweet.address = 'a' * 31
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include('住所は30文字以内で入力してください')
      end
      it '何かひとことが空だと投稿は保存できない' do
        @tweet.content = ''
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include('何かひとことを入力してください')
      end
      it '何かひとことが101文字以上だと投稿は保存できない' do
        @tweet.content = 'a' * 101
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include('何かひとことは100文字以内で入力してください')
      end
      it 'コースに対する対象者が空だと投稿は保存できない' do
        @tweet.level = ''
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include('対象者を入力してください')
      end
      it 'ユーザーが紐付いていないと投稿は保存できない' do
        @tweet.user = nil
        @tweet.valid?
        expect(@tweet.errors.full_messages).to include('Userを入力してください')
      end
    end
  end

  describe 'アソシエーション' do
    let(:association) do
       described_class.reflect_on_association(target)
    end

    context 'Messageモデルとの関係' do
      let(:target) { :messages }
      it '1:多' do
        expect(association.macro).to eq :has_many
      end
      it '結合するモデルのクラス名：Message' do
        expect(association.class_name).to eq 'Message'
      end
    end

    context 'Likeモデルとの関係' do
      let(:target) { :likes }
      it '1:多' do
        expect(association.macro).to eq :has_many
      end
      it '結合するモデルのクラス名：Like' do
        expect(association.class_name).to eq 'Like'
      end
    end

    context 'Tagモデルとの関係' do
      let(:target) { :tags }
      it '1:多' do
        expect(association.macro).to eq :has_many
      end
      it '結合するモデルのクラス名：TagTweet' do
        expect(association.class_name).to eq 'Tag'
      end
    end

    context 'TagTweetモデルとの関係' do
      let(:target) { :tag_tweets }
      it '1:多' do
        expect(association.macro).to eq :has_many
      end
      it '結合するモデルのクラス名：TagTweet' do
        expect(association.class_name).to eq 'TagTweet'
      end
    end

    context 'Notificationモデルとの関係' do
      let(:target) { :notifications }
      it '1:多' do
        expect(association.macro).to eq :has_many
      end
      it '結合するモデルのクラス：Notification' do
        expect(association.class_name).to eq 'Notification'
      end
    end

    context 'Userモデルとの関係' do
      let(:target) { :user }
      it '1:1' do
        expect(association.macro).to eq :belongs_to
      end
      it '結合するモデルのクラス：User' do
        expect(association.class_name).to eq 'User'
      end
    end
  end
end
