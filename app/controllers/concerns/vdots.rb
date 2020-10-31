module Vdots
  extend ActiveSupport::Concern

  # 各ベストタイムのレコードを取得
  def get_record(user_id)
    @five_record = FiveKmRecord.find_by(user_id: user_id)
    @ten_record = TenKmRecord.find_by(user_id: user_id)
    @half_record = HalfRecord.find_by(user_id: user_id)
    @full_record = FullRecord.find_by(user_id: user_id)
    @vdot_second_all = VdotRecordChangeSecond.all
  end

  # 登録してある5kmのベストタイムを元に、5kmのvdot（走力レベル）を取得
  def get_five_vdot
    if @five_record.nil?
      @five_vdot = 1
    else
      # 秒数に変換
      five_minute = @five_record.minute[:name].to_i * 60
      five_second = @five_record.second[:name].to_i
      change_seconds_to_five = five_minute + five_second

      # 条件に一致したレコードのidを、走力レベルとして代入
      five_vdot_hash = @vdot_second_all.filter { |item| item.five_record_from >= change_seconds_to_five && change_seconds_to_five > item.five_record_to}
      five_vdot =  five_vdot_hash[0]
      @five_vdot =  five_vdot.id
    end
  end

  # 登録してある10kmのベストタイムを元に、10kmのvdot（走力レベル）を取得
  def get_ten_vdot
    if @ten_record.nil?
      @ten_vdot = 1
    else
      # 秒数に変換
      ten_minute = @ten_record.minute[:name].to_i * 60
      ten_second = @ten_record.second[:name].to_i
      change_seconds_to_ten = ten_minute + ten_second

      # 条件に一致したレコードのidを、走力レベルとして代入
      ten_vdot_hash = @vdot_second_all.filter { |item| item.ten_record_from >= change_seconds_to_ten && change_seconds_to_ten > item.ten_record_to}
      ten_vdot =  ten_vdot_hash[0]
      @ten_vdot =  ten_vdot.id
    end
  end

  # 登録してあるハーフのベストタイムを元に、ハーフのvdot（走力レベル）を取得
  def get_half_vdot
    if @half_record.nil?
      @half_vdot = 1
    else
      # 秒数に変換
      half_hour = @half_record.hour[:name].to_i * 3600
      half_minute = @half_record.minute[:name].to_i * 60
      half_second = @half_record.second[:name].to_i
      change_seconds_to_half = half_hour + half_minute + half_second

      # 条件に一致したレコードのidを、走力レベルとして代入
      half_vdot_hash = @vdot_second_all.filter { |item| item.half_record_from >= change_seconds_to_half && change_seconds_to_half > item.half_record_to}
      half_vdot =  half_vdot_hash[0]
      @half_vdot =  half_vdot.id
    end
  end

  # 登録してあるフルのベストタイムを元に、フルのvdot（走力レベル）を取得
  def get_full_vdot
    if @full_record.nil?
      @full_vdot = 1
    else
      # 秒数に変換
      full_hour = @full_record.hour[:name].to_i * 3600
      full_minute = @full_record.minute[:name].to_i * 60
      full_second = @full_record.second[:name].to_i
      change_seconds_to_full = full_hour + full_minute + full_second

      # 条件に一致したレコードのidを、走力レベルとして代入
      full_vdot_hash = @vdot_second_all.filter { |item| item.full_record_from >= change_seconds_to_full && change_seconds_to_full > item.full_record_to}
      full_vdot =  full_vdot_hash[0]
      @full_vdot =  full_vdot.id
    end
  end

  # 上記メソッドにて取得した走力レベルより、同レベルの各距離タイムと推奨ペースを取得
  def target_record_and_pace
    # 自分の5kmの走力レベルに対する、同レベルの各距離タイムと推奨ペースを取得
    @vdot_record_five = VdotRecord.find(@five_vdot)
    @vdot_pace_five = VdotPace.find(@five_vdot)

    # 自分の10kmの走力レベルに対する、同レベルの各距離タイムと推奨ペースを取得
    @vdot_record_ten = VdotRecord.find(@ten_vdot)
    @vdot_pace_ten = VdotPace.find(@ten_vdot)

    # 自分のハーフの走力レベルに対する、同レベルの各距離タイムと推奨ペースを取得
    @vdot_record_half = VdotRecord.find(@half_vdot)
    @vdot_pace_half = VdotPace.find(@half_vdot)

    # 自分のフルの走力レベルに対する、同レベルの各距離タイムと推奨ペースを取得
    @vdot_record_full = VdotRecord.find(@full_vdot)
    @vdot_pace_full = VdotPace.find(@full_vdot)
  end
end
