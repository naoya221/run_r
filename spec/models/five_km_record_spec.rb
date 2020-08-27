require 'rails_helper'
describe FiveKmRecord do
  before do
    @five_km_record = FactoryBot.build(:five_km_record)
  end

  describe '5kmのベストタイムの保存' do
    context "5kmのベストタイムが保存できる場合" do
      it "ベストタイム（分・秒）があれば保存される" do
        expect(@five_km_record).to be_valid
      end
    end

    context "5kmのベストタイムが保存できない場合" do
      it "ベストタイム（分）が空だと保存できない" do
        @five_km_record.minute_id = ""
        @five_km_record.valid?
        expect(@five_km_record.errors.full_messages).to include("Minute can't be blank")
      end     
      it "ベストタイム（秒）が空だと保存できない" do
        @five_km_record.second_id = ""
        @five_km_record.valid?
        expect(@five_km_record.errors.full_messages).to include("Second can't be blank")
      end
      it "登録したユーザーが紐付いていないとベストタイムは保存できない" do
        @five_km_record.user = nil
        @five_km_record.valid?
        expect(@five_km_record.errors.full_messages).to include("User must exist")
      end
    end
  end
end
