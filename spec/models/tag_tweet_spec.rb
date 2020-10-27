require 'rails_helper'
describe TagTweet do
  describe 'アソシエーション' do
    let(:association) do
       described_class.reflect_on_association(target)
    end

    context 'Tweetモデルとの関係' do
      let(:target) { :tweet }
      it '多:1' do
        expect(association.macro).to eq :belongs_to
      end
      it '結合するモデルのクラス名：Tweet' do
        expect(association.class_name).to eq 'Tweet'
      end
    end

    context 'Tagモデルとの関係' do
      let(:target) { :tag }
      it '多:1' do
        expect(association.macro).to eq :belongs_to
      end
      it '結合するモデルのクラス名：Tag' do
        expect(association.class_name).to eq 'Tag'
      end
    end
  end
end

