class HalfRecordsController < ApplicationController

  def create
    half_record = HalfRecord.new(permit_params)
    if half_record.save
      redirect_to user_path(current_user.id)
    else
      redirect_to new_record_path
    end
  end

  def update
    half_record = HalfRecord.where(user_id: current_user.id)
    if half_record.update(permit_params)
      redirect_to user_path(current_user.id)
    else
      redirect_to root_path
    end
  end

  def destroy
    half_record = HalfRecord.where(user_id: current_user.id)
    half_record = half_record.ids
    half_record = HalfRecord.find(half_record[0])
    if half_record.destroy
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
