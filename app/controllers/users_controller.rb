class UsersController < ApplicationController

  def show
    params_present
    @user = User.find(params[:id])
    @tweets = @user.tweets.page(params[:page]).per(8).order('created_at DESC')
  end

  private

  def params_present
    if FiveKmRecord.where(user_id: params[:id]).present?
      @five_record = FiveKmRecord.find_by(user_id: params[:id])
    end
    if TenKmRecord.where(user_id: params[:id]).present?
      @ten_record = TenKmRecord.find_by(user_id: params[:id])
    end
    if HalfRecord.where(user_id: params[:id]).present?
      @half_record = HalfRecord.find_by(user_id: params[:id])
    end
    if FullRecord.where(user_id: params[:id]).present?
      @full_record = FullRecord.find_by(user_id: params[:id])
    end
  end

end
