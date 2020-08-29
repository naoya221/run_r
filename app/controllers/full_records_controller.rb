class FullRecordsController < ApplicationController

  def create
    full_record = FullRecord.new(permit_params)
    if full_record.save
      flash[:notice_full_new] = "フルのべストタイムを登録しました！"
      redirect_to new_record_path
    else
      redirect_to root_path
    end
  end

  def update
    full_record = FullRecord.where(user_id: current_user.id)
    if full_record.update(permit_params)
      flash[:notice_full_edit] = "フルのべストタイムを編集しました！"
      redirect_to edit_record_path
    else
      redirect_to root_path
    end
  end

  def destroy
    full_record = FullRecord.where(user_id: current_user.id)
    full_record = full_record.ids
    full_record = FullRecord.find(full_record[0])
    if full_record.destroy
      flash[:notice_full_de] = "フルのべストタイムを削除しました！"
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