class HalfRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_record, only: [:update, :destroy]

  def create
    half_record = HalfRecord.new(record_params)
    if half_record.save
      redirect_to new_record_path, notice: 'ハーフのべストタイムを登録しました！'
    else
      redirect_to root_path
    end
  end

  def update
    set_record
    if @half_record.update(record_params)
      redirect_to edit_record_path, notice: 'ハーフのべストタイムを編集しました！'
    else
      redirect_to root_path
    end
  end

  def destroy
    set_record
    if @half_record.destroy
      redirect_to edit_record_path, notice: 'ハーフのべストタイムを削除しました！'
    else
      redirect_to root_path
    end
  end

  private

  def set_record
    @half_record = HalfRecord.find_by(user_id: current_user.id)
  end

  def record_params
    params.permit(:hour_id, :minute_id, :second_id).merge(user_id: current_user.id)
  end
end
