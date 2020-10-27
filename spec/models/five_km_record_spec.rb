require 'rails_helper'
describe FiveKmRecord do
  before do
    @five_km_record = FactoryBot.build(:five_km_record)
  end

  describe '5kmのベストタイムの保存' do
    context '5kmのベストタイムが保存できる場合' do
      it 'ベストタイム（分・秒）があれば保存される' do
        expect(@five_km_record).to be_valid
      end
    end

    context '5kmのベストタイムが保存できない場合' do
      it 'ベストタイム（分）が空だと保存できない' do
        @five_km_record.minute_id = ''
        @five_km_record.valid?
        expect(@five_km_record.errors.full_messages).to include('Minuteを入力してください')
      end
      it 'ベストタイム（秒）が空だと保存できない' do
        @five_km_record.second_id = ''
        @five_km_record.valid?
        expect(@five_km_record.errors.full_messages).to include('Secondを入力してください')
      end
      it '登録したユーザーが紐付いていないとベストタイムは保存できない' do
        @five_km_record.user = nil
        @five_km_record.valid?
        expect(@five_km_record.errors.full_messages).to include('Userを入力してください')
      end
    end
  end

  describe 'アソシエーション' do
    let(:association) do
       described_class.reflect_on_association(target)
    end

    context 'Minuteモデルとの関係' do
      let(:target) { :minute }
      it '多:1' do
        expect(association.macro).to eq :belongs_to
      end
      it '結合するモデルのクラス名：Minute' do
        expect(association.class_name).to eq 'Minute'
      end
    end

    context 'Secondモデルとの関係' do
      let(:target) { :second }
      it '多:1' do
        expect(association.macro).to eq :belongs_to
      end
      it '結合するモデルのクラス名：Second' do
        expect(association.class_name).to eq 'Second'
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
