require 'rails_helper'
describe Tag do
  describe 'アソシエーション' do
    let(:association) do
       described_class.reflect_on_association(target)
    end

    context 'Tweetモデルとの関係' do
      let(:target) { :tweets }
      it '1:多' do
        expect(association.macro).to eq :has_many
      end
      it '結合するモデルのクラス名：Tweet' do
        expect(association.class_name).to eq 'Tweet'
      end
    end

    context 'TagTweetモデルとの関係' do
      let(:target) { :tag_tweets }
      it '1:多' do
        expect(association.macro).to eq :has_many
      end
      it '結合するモデルのクラス名：TagTweets' do
        expect(association.class_name).to eq 'TagTweet'
      end
    end
  end
end

