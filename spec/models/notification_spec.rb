require 'rails_helper'
describe Notification do
  describe 'アソシエーション' do
    let(:association) do
       described_class.reflect_on_association(target)
    end

    context 'User（visitor）モデルとの関係' do
      let(:target) { :visitor }
      it '多:1' do
        expect(association.macro).to eq :belongs_to
      end
      it '結合するモデルのクラス：User' do
        expect(association.class_name).to eq 'User'
      end
    end

    context 'User（visited）モデルとの関係' do
      let(:target) { :visited }
      it '多:1' do
        expect(association.macro).to eq :belongs_to
      end
      it '結合するモデルのクラス：User' do
        expect(association.class_name).to eq 'User'
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

    context 'Messageモデルとの関係' do
      let(:target) { :message }
      it '多:1' do
        expect(association.macro).to eq :belongs_to
      end
      it '結合するモデルのクラス名：Message' do
        expect(association.class_name).to eq 'Message'
      end
    end
  end
end

