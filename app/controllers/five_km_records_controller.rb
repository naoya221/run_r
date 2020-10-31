class FiveKmRecordsController < ApplicationController
  # 未ログイン者の制限
  before_action :authenticate_user!

  # ログイン者の5kmのベストタイムを取得
  before_action :set_record, only: [:update, :destroy]

  def create
    five_record = FiveKmRecord.new(record_params)
    if five_record.save
      redirect_to new_record_path, notice: '5kmのべストタイムを登録しました！'
    else
      redirect_to root_path
    end
  end

  def update
    set_record
    if @five_record.update(record_params)
      redirect_to edit_record_path, notice: '5kmのべストタイムを編集しました！'
    else
      redirect_to root_path
    end
  end

  def destroy
    set_record
    if @five_record.destroy
      redirect_to edit_record_path, notice: '5kmのべストタイムを削除しました！'
    else
      redirect_to root_path
    end
  end

  private

  # ログイン者の5kmのベストタイムを取得
  def set_record
    @five_record = FiveKmRecord.find_by(user_id: current_user.id)
  end

  # 外部入力を許可したカラム
  def record_params
    params.permit(:hour_id, :minute_id, :second_id).merge(user_id: current_user.id)
  end
end
