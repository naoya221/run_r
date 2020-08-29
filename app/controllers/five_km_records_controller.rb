class FiveKmRecordsController < ApplicationController
  
  def create
    five_km_record = FiveKmRecord.new(permit_params)
    if five_km_record.save
      flash[:notice_five_new] = "5kmのべストタイムを登録しました！"
      redirect_to new_record_path
    else
      redirect_to root_path
    end
  end

  def update
    five_km_record = FiveKmRecord.where(user_id: current_user.id)
    if five_km_record.update(permit_params)
      flash[:notice_five_edit] = "5kmのベストタイムを編集しました！"
      redirect_to edit_record_path
    else
      redirect_to root_path
    end
  end

  def destroy
    five_km_record = FiveKmRecord.where(user_id: current_user.id)
    five_km_record = five_km_record.ids
    five_km_record = FiveKmRecord.find(five_km_record[0])
    if five_km_record.destroy
      flash[:notice_five_de] = "5kmのべストタイムを削除しました！"
      redirect_to edit_record_path
    else
      redirect_to root_path
    end
  end

  private

  def permit_params
    params.permit(:hour_id, :minute_id, :second_id).merge(user_id: current_user.id)
  end
end