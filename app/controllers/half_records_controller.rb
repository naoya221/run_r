class HalfRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_record, only: [:update, :destroy]

  def create
    half_record = HalfRecord.new(permit_params)
    if half_record.save
      flash[:notice] = 'ハーフのべストタイムを登録しました！'
      redirect_to new_record_path
    else
      redirect_to root_path
    end
  end

  def update
    set_record
    if @half_record.update(permit_params)
      flash[:notice] = 'ハーフのべストタイムを編集しました！'
      redirect_to edit_record_path
    else
      redirect_to root_path
    end
  end

  def destroy
    set_record
    if @half_record.destroy
      flash[:notice] = 'ハーフのべストタイムを削除しました！'
      redirect_to edit_record_path
    else
      redirect_to root_path
    end
  end

  private

  def set_record
    @half_record = HalfRecord.find_by(user_id: current_user.id)
  end

  def permit_params
    params.permit(:hour_id, :minute_id, :second_id).merge(user_id: current_user.id)
  end
end
