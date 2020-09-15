class FullRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_record, only: [:update, :destroy]

  def create
    full_record = FullRecord.new(record_params)
    if full_record.save
      redirect_to new_record_path, notice: 'フルのべストタイムを登録しました！'
    else
      redirect_to root_path
    end
  end

  def update
    set_record
    if @full_record.update(record_params)
      redirect_to edit_record_path, notice: 'フルのべストタイムを編集しました！'
    else
      redirect_to root_path
    end
  end

  def destroy
    set_record
    if @full_record.destroy
      redirect_to edit_record_path, notice: 'フルのべストタイムを削除しました！'
    else
      redirect_to root_path
    end
  end

  private

  def set_record
    @full_record = FullRecord.find_by(user_id: current_user.id)
  end

  def record_params
    params.permit(:hour_id, :minute_id, :second_id).merge(user_id: current_user.id)
  end
end
