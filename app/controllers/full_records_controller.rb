class FullRecordsController < ApplicationController

  def create
    @full_record = FullRecord.new(permit_params)
    if @full_record.save
      redirect_to user_path(current_user.id)
    else
      redirect_to new_record_path
    end
  end

  def update
    @full_record = FullRecord.where(user_id: current_user.id)
    if @full_record.update(permit_params)
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
