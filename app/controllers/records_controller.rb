class RecordsController < ApplicationController
  # 未ログイン者の制限
  before_action :authenticate_user!

  def new
  end

  def edit
    user = User.find(params[:id])
    redirect_to user_path(current_user.id), notice: '自分以外のベストタイムは編集できません' if current_user.id != user.id

    # ログイン者の各ベストタイムを取得（存在すれば）
    get_record
  end

  private

  # ログイン者の各ベストタイムを取得（存在すれば）
  def get_record
    @five_record = FiveKmRecord.find_by(user_id: current_user.id) if FiveKmRecord.where(user_id: current_user.id).present?
    @ten_record = TenKmRecord.find_by(user_id: current_user.id) if TenKmRecord.where(user_id: current_user.id).present?
    @half_record = HalfRecord.find_by(user_id: current_user.id) if HalfRecord.where(user_id: current_user.id).present?
    @full_record = FullRecord.find_by(user_id: current_user.id) if FullRecord.where(user_id: current_user.id).present?
  end
end
