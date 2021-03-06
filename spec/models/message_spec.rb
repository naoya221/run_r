require 'rails_helper'
describe Message do
  before do
    @message = FactoryBot.build(:message)
  end

  describe 'コメントの保存' do
    context 'コメントが保存できる場合' do
      it 'テキストがあれば保存される' do
        expect(@message).to be_valid
      end
    end

    context 'コメントが保存できない場合' do
      it 'テキストが空だとコメントは保存できない' do
        @message.text = ''
        @message.valid?
        expect(@message.errors.full_messages).to include('テキストを入力してください')
      end
      it 'ユーザーが紐付いていないとコメントは保存できない' do
        @message.user = nil
        @message.valid?
        expect(@message.errors.full_messages).to include('Userを入力してください')
      end
      it 'コメントされている投稿が紐付いていないとコメントは保存できない' do
        @message.tweet = nil
        @message.valid?
        expect(@message.errors.full_messages).to include('Tweetを入力してください')
      end
    end
  end

  describe 'アソシエーション' do
    let(:association) do
       described_class.reflect_on_association(target)
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

    context 'TWeetモデルとの関係' do
      let(:target) { :tweet }
      it '多:1' do
        expect(association.macro).to eq :belongs_to
      end
      it '結合するモデルのクラス名：Tweet' do
        expect(association.class_name).to eq 'Tweet'
      end
    end

    context 'Userモデルとの関係' do
      let(:target) { :user }
      it '多:1' do
        expect(association.macro).to eq :belongs_to
      end
      it '結合するモデルのクラス名：User' do
        expect(association.class_name).to eq 'User'
      end
    end
  end
end
