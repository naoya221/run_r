class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.page(params[:page]).per(8).order('created_at DESC')
    params_present    # ユーザーのベストタイムを取得
  end

  private

  def params_present
    @five_record = FiveKmRecord.find_by(user_id: params[:id]) if FiveKmRecord.where(user_id: params[:id]).present?
    @ten_record = TenKmRecord.find_by(user_id: params[:id]) if TenKmRecord.where(user_id: params[:id]).present?
    @half_record = HalfRecord.find_by(user_id: params[:id]) if HalfRecord.where(user_id: params[:id]).present?
    @full_record = FullRecord.find_by(user_id: params[:id]) if FullRecord.where(user_id: params[:id]).present?
  end
end
