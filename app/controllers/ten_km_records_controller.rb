class TenKmRecordsController < ApplicationController

  def create
    ten_km_record = TenKmRecord.new(permit_params)
    if ten_km_record.save
      flash[:notice_ten_new] = "10kmのべストタイムを登録しました！"
      redirect_to new_record_path
    else
      redirect_to root_path
    end
  end

  def update
    ten_km_record = TenKmRecord.where(user_id: current_user.id)
    if ten_km_record.update(permit_params)
      flash[:notice_ten_edit] = "10kmのベストタイムを編集しました！"
      redirect_to edit_record_path
    else
      redirect_to root_path
    end
  end

  def destroy
    ten_km_record = TenKmRecord.where(user_id: current_user.id)
    ten_km_record = ten_km_record.ids
    ten_km_record = TenKmRecord.find(ten_km_record[0])
    if ten_km_record.destroy
      flash[:notice_ten_de] = "10kmのべストタイムを削除しました！"
      redirect_to user_path(current_user.id)
    else
      redirect_to root_path
    end
  end

  private

  def permit_params
    params.permit(:hour_id, :minute_id, :second_id).merge(user_id: current_user.id)
  end

end
