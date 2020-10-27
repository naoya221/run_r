require 'rails_helper'
describe FollowRelationship do
  describe 'アソシエーション' do
    let(:association) do
       described_class.reflect_on_association(target)
    end

    context 'User（follower）モデルとの関係' do
      let(:target) { :follower }
      it '多:1' do
        expect(association.macro).to eq :belongs_to
      end
      it '結合するモデルのクラス：User' do
        expect(association.class_name).to eq 'User'
      end
    end

    context 'User（following）モデルとの関係' do
      let(:target) { :following }
      it '多:1' do
        expect(association.macro).to eq :belongs_to
      end
      it '結合するモデルのクラス：User' do
        expect(association.class_name).to eq 'User'
      end
    end
  end
end
