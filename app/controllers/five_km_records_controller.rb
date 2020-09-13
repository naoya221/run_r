class FiveKmRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_record, only: [:update, :destroy]

  def create
    five_record = FiveKmRecord.new(permit_params)
    if five_record.save
      flash[:notice] = '5kmのべストタイムを登録しました！'
      redirect_to new_record_path
    else
      redirect_to root_path
    end
  end

  def update
    set_record
    if @five_record.update(permit_params)
      flash[:notice] = '5kmのベストタイムを編集しました！'
      redirect_to edit_record_path
    else
      redirect_to root_path
    end
  end

  def destroy
    set_record
    if @five_record.destroy
      flash[:notice] = '5kmのべストタイムを削除しました！'
      redirect_to edit_record_path
    else
      redirect_to root_path
    end
  end

  private

  def set_record
    @five_record = FiveKmRecord.find_by(user_id: current_user.id)
  end

  def permit_params
    params.permit(:hour_id, :minute_id, :second_id).merge(user_id: current_user.id)
  end
end
