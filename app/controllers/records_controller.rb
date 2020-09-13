class RecordsController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = User.find(current_user.id)
  end

  def edit
    @user = User.find(current_user.id)
    user = User.find(params[:id])
    if @user.id != user.id
      flash[:notice] = '自分以外のベストタイムは編集できません'
      redirect_to user_path(current_user.id)
    end

    if FiveKmRecord.where(user_id: current_user.id).present?
      @five_record = FiveKmRecord.find_by(user_id: current_user.id)
    end
    if TenKmRecord.where(user_id: current_user.id).present?
      @ten_record = TenKmRecord.find_by(user_id: current_user.id)
    end
    if HalfRecord.where(user_id: current_user.id).present?
      @half_record = HalfRecord.find_by(user_id: current_user.id)
    end
    if FullRecord.where(user_id: current_user.id).present?
      @full_record = FullRecord.find_by(user_id: current_user.id)
    end
  end
end
