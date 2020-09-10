class RecordsController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = User.find(current_user.id)
  end

  def edit
    @user = User.find(current_user.id)

    if FiveKmRecord.where(user_id: current_user.id).present?
      five_record = FiveKmRecord.where(user_id: current_user.id).ids
      @five_record = FiveKmRecord.find(five_record[0])
    end
    if TenKmRecord.where(user_id: current_user.id).present?
      ten_record = TenKmRecord.where(user_id: current_user.id).ids
      @ten_record = TenKmRecord.find(ten_record[0])
    end
    if HalfRecord.where(user_id: current_user.id).present?
      half_record = HalfRecord.where(user_id: current_user.id).ids
      @half_record = HalfRecord.find(half_record[0])
    end
    if FullRecord.where(user_id: current_user.id).present?
      full_record = FullRecord.where(user_id: current_user.id).ids
      @full_record = FullRecord.find(full_record[0])
    end  

  end


end
