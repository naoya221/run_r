require 'rails_helper'
describe HalfRecord do
  before do
    @half_record = FactoryBot.build(:half_record)
  end

  describe 'ハーフのベストタイムの保存' do
    context "ハーフのベストタイムが保存できる場合" do
      it "ベストタイム（時間・分・秒）があれば保存される" do
        expect(@half_record).to be_valid
      end
    end

    context "ハーフのベストタイムが保存できない場合" do
      it "ベストタイム（時間）が空だと保存できない" do
        @half_record.hour_id = ""
        @half_record.valid?
        expect(@half_record.errors.full_messages).to include("Hour can't be blank")
      end   
      it "ベストタイム（分）が空だと保存できない" do
        @half_record.minute_id = ""
        @half_record.valid?
        expect(@half_record.errors.full_messages).to include("Minute can't be blank")
      end     
      it "ベストタイム（秒）が空だと保存できない" do
        @half_record.second_id = ""
        @half_record.valid?
        expect(@half_record.errors.full_messages).to include("Second can't be blank")
      end
      it "登録したユーザーが紐付いていないとベストタイムは保存できない" do
        @half_record.user = nil
        @half_record.valid?
        expect(@half_record.errors.full_messages).to include("User must exist")
      end
    end
  end
end
