class HalfRecordsController < ApplicationController

  def create
    @half_km_record = HalfKmRecord.new(permit_params)
    if @half_km_record.save
      redirect_to user_path(current_user.id)
    else
      redirect_to new_record_path
    end
  end

  def update
    @half_km_record = HalfKmRecord.where(user_id: current_user.id)
    if @half_km_record.update(permit_params)
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
