class UsersController < ApplicationController
  before_action :params_present
  before_action :set_params
  before_action :set_nickname

  def show
    @tweets = @user.tweets.page(params[:page]).per(8).order('created_at DESC')
  end

  private

  def set_params
    @user = User.find(params[:id])
  end

  def set_nickname
    @nickname = @user.nickname
  end

  def permit_params
    params.require(:user).permit(:nickname)
  end

  def params_present
    if FiveKmRecord.where(user_id: params[:id]).present?
      five_km_record_id_hash = FiveKmRecord.where(user_id: params[:id])
      five_km_record_id = five_km_record_id_hash.ids
      @five_km_record = FiveKmRecord.find(five_km_record_id[0])
    end
    if TenKmRecord.where(user_id: params[:id]).present?
      ten_km_record_id_hash = TenKmRecord.where(user_id: params[:id])
      ten_km_record_id = ten_km_record_id_hash.ids
      @ten_km_record = TenKmRecord.find(ten_km_record_id[0])
    end
    if HalfRecord.where(user_id: params[:id]).present?
      half_record_id_hash = HalfRecord.where(user_id: params[:id])
      half_record_id = half_record_id_hash.ids
      @half_record = HalfRecord.find(half_record_id[0])
    end
    if FullRecord.where(user_id: params[:id]).present?
      full_record_id_hash = FullRecord.where(user_id: params[:id])
      full_record_id = full_record_id_hash.ids
      @full_record = FullRecord.find(full_record_id[0])
    end
  end
end
