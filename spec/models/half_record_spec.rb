require 'rails_helper'
describe HalfRecord do
  before do
    @half_record = FactoryBot.build(:half_record)
  end

  describe 'ハーフのベストタイムの保存' do
    context 'ハーフのベストタイムが保存できる場合' do
      it 'ベストタイム（時間・分・秒）があれば保存される' do
        expect(@half_record).to be_valid
      end
    end

    context 'ハーフのベストタイムが保存できない場合' do
      it 'ベストタイム（時間）が空だと保存できない' do
        @half_record.hour_id = ''
        @half_record.valid?
        expect(@half_record.errors.full_messages).to include('Hourを入力してください')
      end
      it 'ベストタイム（分）が空だと保存できない' do
        @half_record.minute_id = ''
        @half_record.valid?
        expect(@half_record.errors.full_messages).to include('Minuteを入力してください')
      end
      it 'ベストタイム（秒）が空だと保存できない' do
        @half_record.second_id = ''
        @half_record.valid?
        expect(@half_record.errors.full_messages).to include('Secondを入力してください')
      end
      it '登録したユーザーが紐付いていないとベストタイムは保存できない' do
        @half_record.user = nil
        @half_record.valid?
        expect(@half_record.errors.full_messages).to include('Userを入力してください')
      end
    end
  end

  describe 'アソシエーション' do
    let(:association) do
       described_class.reflect_on_association(target)
    end

    context 'Hourモデルとの関係' do
      let(:target) { :hour }
      it '多:1' do
        expect(association.macro).to eq :belongs_to
      end
      it '結合するモデルのクラス名：Hour' do
        expect(association.class_name).to eq 'Hour'
      end
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
