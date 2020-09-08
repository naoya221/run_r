require 'rails_helper'
describe TenKmRecord do
  before do
    @ten_km_record = FactoryBot.build(:ten_km_record)
  end

  describe '10kmのベストタイムの保存' do
    context "10kmのベストタイムが保存できる場合" do
      it "ベストタイム（分・秒）があれば保存される" do
        expect(@ten_km_record).to be_valid
      end
    end

    context "10kmのベストタイムが保存できない場合" do
      it "ベストタイム（分）が空だと保存できない" do
        @ten_km_record.minute_id = ""
        @ten_km_record.valid?
        expect(@ten_km_record.errors.full_messages).to include("Minuteを入力してください")
      end     
      it "ベストタイム（秒）が空だと保存できない" do
        @ten_km_record.second_id = ""
        @ten_km_record.valid?
        expect(@ten_km_record.errors.full_messages).to include("Secondを入力してください")
      end
      it "登録したユーザーが紐付いていないとベストタイムは保存できない" do
        @ten_km_record.user = nil
        @ten_km_record.valid?
        expect(@ten_km_record.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end
