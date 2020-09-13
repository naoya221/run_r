class TenKmRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_record, only: [:update, :destroy]

  def create
    ten_record = TenKmRecord.new(permit_params)
    if ten_record.save
      flash[:notice] = '10kmのべストタイムを登録しました！'
      redirect_to new_record_path
    else
      redirect_to root_path
    end
  end

  def update
    set_record
    if @ten_record.update(permit_params)
      flash[:notice] = '10kmのベストタイムを編集しました！'
      redirect_to edit_record_path
    else
      redirect_to root_path
    end
  end

  def destroy
    set_record
    if @ten_record.destroy
      flash[:notice] = '10kmのべストタイムを削除しました！'
      redirect_to edit_record_path
    else
      redirect_to root_path
    end
  end

  private

  def set_record
    @ten_record = TenKmRecord.find_by(user_id: current_user.id)
  end

  def permit_params
    params.permit(:hour_id, :minute_id, :second_id).merge(user_id: current_user.id)
  end
end
