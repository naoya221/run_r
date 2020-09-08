require 'rails_helper'
describe FullRecord do
  before do
    @full_record = FactoryBot.build(:full_record)
  end

  describe 'フルのベストタイムの保存' do
    context "フルのベストタイムが保存できる場合" do
      it "ベストタイム（時間・分・秒）があれば保存される" do
        expect(@full_record).to be_valid
      end
    end

    context "フルのベストタイムが保存できない場合" do
      it "ベストタイム（時間）が空だと保存できない" do
        @full_record.hour_id = ""
        @full_record.valid?
        expect(@full_record.errors.full_messages).to include("Hourを入力してください")
      end   
      it "ベストタイム（分）が空だと保存できない" do
        @full_record.minute_id = ""
        @full_record.valid?
        expect(@full_record.errors.full_messages).to include("Minuteを入力してください")
      end     
      it "ベストタイム（秒）が空だと保存できない" do
        @full_record.second_id = ""
        @full_record.valid?
        expect(@full_record.errors.full_messages).to include("Secondを入力してください")
      end
      it "登録したユーザーが紐付いていないとベストタイムは保存できない" do
        @full_record.user = nil
        @full_record.valid?
        expect(@full_record.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end
