module Vdots
  extend ActiveSupport::Concern

  def get_record(user_id)    # 各ベストタイムのレコードを取得
    @five_record = FiveKmRecord.find_by(user_id: user_id)
    @ten_record = TenKmRecord.find_by(user_id: user_id)
    @half_record = HalfRecord.find_by(user_id: user_id)
    @full_record = FullRecord.find_by(user_id: user_id)
  end

  def get_five_vdot    # 登録してある5kmのベストタイムを元に、5kmのvdot（走力レベル）を取得
    if @five_record == nil
      @five_vdot = 1
    else
      @five_minute = @five_record.minute[:name].to_i
      @five_second = @five_record.second[:name].to_i
      @five_vdot = if @five_minute >= 30 && @five_second > 40 || @five_minute >= 31
                     1
                   elsif @five_minute >= 29 && @five_second > 51 || @five_minute >= 30 && 40 >= @five_second
                     2
                   elsif @five_minute >= 29 && @five_second > 5
                     3
                   elsif @five_minute >= 28 && @five_second > 21 || @five_minute >= 29 && 5 >= @five_second
                     4
                   elsif @five_minute >= 27 && @five_second > 39 || @five_minute >= 28 && 21 >= @five_second
                     5
                   elsif @five_minute >= 27 && @five_second > 0
                     6
                   elsif @five_minute >= 26 && @five_second > 22
                     7
                   elsif @five_minute >= 25 && @five_second > 46 || @five_minute >= 26 && 22 >= @five_second
                     8
                   elsif @five_minute >= 25 && @five_second > 12
                     9
                   elsif @five_minute >= 24 && @five_second > 39 || @five_minute >= 25 && 12 >= @five_second
                     10
                   elsif @five_minute >= 24 && @five_second > 8
                     11
                   elsif @five_minute >= 23 && @five_second > 38 || @five_minute >= 24 && 8 >= @five_second
                     12
                   elsif @five_minute >= 23 && @five_second > 9
                     13
                   elsif @five_minute >= 22 && @five_second > 41 || @five_minute >= 23 && 9 >= @five_second
                     14
                   elsif @five_minute >= 22 && @five_second > 15
                     15
                   elsif @five_minute >= 21 && @five_second > 50 || @five_minute >= 22 && 15 >= @five_second
                     16
                   elsif @five_minute >= 21 && @five_second > 25
                     17
                   elsif @five_minute >= 21 && @five_second > 2
                     18
                   elsif @five_minute >= 20 && @five_second > 39 || @five_minute >= 21 && 2 >= @five_second
                     19
                   elsif @five_minute >= 20 && @five_second > 18
                     20
                   elsif @five_minute >= 19 && @five_second > 57 || @five_minute >= 20 && 18 >= @five_second
                     21
                   elsif @five_minute >= 19 && @five_second > 36
                     22
                   elsif @five_minute >= 19 && @five_second > 17
                     23
                   elsif @five_minute >= 18 && @five_second > 58 || @five_minute >= 19 && 17 >= @five_second
                     24
                   else
                     25
                   end
    end
  end

  def get_ten_vdot    # 登録してある10kmのベストタイムを元に、10kmのvdot（走力レベル）を取得
    if @ten_record == nil
      @ten_vdot = 1
    else
      @ten_minute = @ten_record.minute[:name].to_i
      @ten_second = @ten_record.second[:name].to_i
      @ten_vdot = if @ten_minute >= 63 && @ten_second > 46 || @ten_minute >= 64
                    1
                  elsif @ten_minute >= 62 && @ten_second > 3 || @ten_minute >= 63 && 46 >= @ten_second
                    2
                  elsif @ten_minute >= 60 && @ten_second > 26 || @ten_minute >= 62 && 3 >= @ten_second || @ten_minute == 61
                    3
                  elsif @ten_minute >= 58 && @ten_second > 54 || @ten_minute >= 60 && 26 >= @ten_second || @ten_minute == 59
                    4
                  elsif @ten_minute >= 57 && @ten_second > 26 || @ten_minute >= 58 && 54 >= @ten_second
                    5
                  elsif @ten_minute >= 56 && @ten_second > 3 || @ten_minute >= 57 && 26 >= @ten_second
                    6
                  elsif @ten_minute >= 54 && @ten_second > 44 || @ten_minute >= 56 && 3 >= @ten_second || @ten_minute >= 55
                    7
                  elsif @ten_minute >= 53 && @ten_second > 29 || @ten_minute >= 54 && 46 >= @ten_second
                    8
                  elsif @ten_minute >= 52 && @ten_second > 17 || @ten_minute >= 53 && 29 >= @ten_second
                    9
                  elsif @ten_minute >= 51 && @ten_second > 9 || @ten_minute >= 52 && 17 >= @ten_second
                    10
                  elsif @ten_minute >= 50 && @ten_second > 3 || @ten_minute >= 51 && 9 >= @ten_second
                    11
                  elsif @ten_minute >= 49 && @ten_second > 1 || @ten_minute >= 50 && 3 >= @ten_second
                    12
                  elsif @ten_minute >= 48 && @ten_second > 1 || @ten_minute >= 49 && 1 >= @ten_second
                    13
                  elsif @ten_minute >= 47 && @ten_second > 4 || @ten_minute >= 48 && 1 >= @ten_second
                    14
                  elsif @ten_minute >= 46 && @ten_second > 9 || @ten_minute >= 47 && 4 >= @ten_second
                    15
                  elsif @ten_minute >= 45 && @ten_second > 16 || @ten_minute >= 46 && 9 >= @ten_second
                    16
                  elsif @ten_minute >= 44 && @ten_second > 25 || @ten_minute >= 45 && 16 >= @ten_second
                    17
                  elsif @ten_minute >= 43 && @ten_second > 36 || @ten_minute >= 44 && 25 >= @ten_second
                    18
                  elsif @ten_minute >= 42 && @ten_second > 50 || @ten_minute >= 43 && 36 >= @ten_second
                    19
                  elsif @ten_minute >= 42 && @ten_second > 4
                    20
                  elsif @ten_minute >= 41 && @ten_second > 21 || @ten_minute >= 42 && 4 >= @ten_second
                    21
                  elsif @ten_minute >= 40 && @ten_second > 39 || @ten_minute >= 41 && 21 >= @ten_second
                    22
                  elsif @ten_minute >= 39 && @ten_second > 59 || @ten_minute >= 40 && 39 >= @ten_second
                    23
                  elsif @ten_minute >= 39 && @ten_second > 20
                    24
                  else
                    25
                  end
    end
  end

  def get_half_vdot    # 登録してあるハーフのベストタイムを元に、ハーフのvdot（走力レベル）を取得
    if @half_record == nil
      @half_vdot = 1
    else
      @half_hour = @half_record.hour[:name].to_i
      @half_minute = @half_record.minute[:name].to_i
      @half_second = @half_record.second[:name].to_i
      @half_vdot = if @half_hour >= 2 && @half_minute >= 21 && @half_second > 4 || @half_hour == 2 && @half_minute >= 22 || @half_hour >= 3
                     1
                   elsif @half_hour >= 2 && @half_minute >= 17 && @half_second > 21 || @half_hour >= 2 && @half_minute >= 21 && 4 >= @half_second || @half_hour >= 2 && @half_minute >= 18
                     2
                   elsif @half_hour >= 2 && @half_minute >= 13 && @half_second > 49 || @half_hour >= 2 && @half_minute >= 17 && 21 >= @half_second || @half_hour >= 2 && @half_minute >= 14
                     3
                   elsif @half_hour >= 2 && @half_minute >= 10 && @half_second > 27 || @half_hour >= 2 && @half_minute >= 13 && 49 >= @half_second || @half_hour >= 2 && @half_minute >= 11
                     4
                   elsif @half_hour >= 2 && @half_minute >= 7 && @half_second > 16 || @half_hour >= 2 && @half_minute >= 10 && 27 >= @half_second || @half_hour >= 2 && @half_minute >= 8
                     5
                   elsif @half_hour >= 2 && @half_minute >= 4 && @half_second > 13 || @half_hour >= 2 && @half_minute >= 7 && 16 >= @half_second || @half_hour >= 2 && @half_minute >= 5
                     6
                   elsif @half_hour >= 2 && @half_minute >= 1 && @half_second > 19 || @half_hour >= 2 && @half_minute >= 4 && 13 >= @half_second || @half_hour >= 2 && @half_minute >= 2
                     7
                   elsif @half_hour >= 1 && @half_minute >= 58 && @half_second > 34 || @half_hour >= 2 && @half_minute >= 1 && 19 >= @half_second || @half_hour >= 2 && @half_minute == 0 || @half_hour >= 1 && @half_minute >= 59
                     8
                   elsif @half_hour >= 1 && @half_minute >= 55 && @half_second > 55 || @half_hour >= 1 && @half_minute >= 58 && 34 >= @half_second || @half_hour >= 1 && @half_minute >= 56
                     9
                   elsif @half_hour >= 1 && @half_minute >= 53 && @half_second > 24 || @half_hour >= 1 && @half_minute >= 55 && 55 >= @half_second || @half_hour >= 1 && @half_minute >= 54
                     10
                   elsif @half_hour >= 1 && @half_minute >= 50 && @half_second > 59 || @half_hour >= 1 && @half_minute >= 53 && 24 >= @half_second || @half_hour >= 1 && @half_minute >= 51
                     11
                   elsif @half_hour >= 1 && @half_minute >= 48 && @half_second > 40 || @half_hour >= 1 && @half_minute >= 50 && 59 >= @half_second || @half_hour >= 1 && @half_minute >= 49
                     12
                   elsif @half_hour >= 1 && @half_minute >= 46 && @half_second > 27 || @half_hour >= 1 && @half_minute >= 48 && 40 >= @half_second || @half_hour >= 1 && @half_minute >= 47
                     13
                   elsif @half_hour >= 1 && @half_minute >= 44 && @half_second > 20 || @half_hour >= 1 && @half_minute >= 46 && 27 >= @half_second || @half_hour >= 1 && @half_minute >= 45
                     14
                   elsif @half_hour >= 1 && @half_minute >= 42 && @half_second > 17 || @half_hour >= 1 && @half_minute >= 44 && 20 >= @half_second || @half_hour >= 1 && @half_minute >= 43
                     15
                   elsif @half_hour >= 1 && @half_minute >= 40 && @half_second > 20 || @half_hour >= 1 && @half_minute >= 42 && 17 >= @half_second || @half_hour >= 1 && @half_minute >= 41
                     16
                   elsif @half_hour >= 1 && @half_minute >= 38 && @half_second > 27 || @half_hour >= 1 && @half_minute >= 40 && 20 >= @half_second || @half_hour >= 1 && @half_minute >= 39
                     17
                   elsif @half_hour >= 1 && @half_minute >= 36 && @half_second > 38 || @half_hour >= 1 && @half_minute >= 38 && 27 >= @half_second || @half_hour >= 1 && @half_minute >= 37
                     18
                   elsif @half_hour >= 1 && @half_minute >= 34 && @half_second > 53 || @half_hour >= 1 && @half_minute >= 36 && 38 >= @half_second || @half_hour >= 1 && @half_minute >= 35
                     19
                   elsif @half_hour >= 1 && @half_minute >= 33 && @half_second > 12 || @half_hour >= 1 && @half_minute >= 34 && 53 >= @half_second
                     20
                   elsif @half_hour >= 1 && @half_minute >= 31 && @half_second > 35 || @half_hour >= 1 && @half_minute >= 33 && 12 >= @half_second || @half_hour >= 1 && @half_minute >= 32
                     21
                   elsif @half_hour >= 1 && @half_minute >= 30 && @half_second > 2 || @half_hour >= 1 && @half_minute >= 31 && 35 >= @half_second
                     22
                   elsif @half_hour >= 1 && @half_minute >= 28 && @half_second > 31 || @half_hour >= 1 && @half_minute >= 30 && 2 >= @half_second || @half_hour >= 1 && @half_minute >= 29
                     23
                   elsif @half_hour >= 1 && @half_minute >= 27 && @half_second > 4 || @half_hour >= 1 && @half_minute >= 28 && 31 >= @half_second
                     24
                   else
                     25
                   end
    end
  end

  def get_full_vdot    # 登録してあるフルのベストタイムを元に、フルのvdot（走力レベル）を取得
    if @full_record == nil
      @full_vdot = 1
    else
      @full_hour = @full_record.hour[:name].to_i
      @full_minute = @full_record.minute[:name].to_i
      @full_second = @full_record.second[:name].to_i
      @full_vdot = if @full_hour >= 4 && @full_minute >= 49 && @full_second > 17 || @full_hour == 4 && @full_minute >= 50 || @full_hour >= 5
                     1
                   elsif @full_hour >= 4 && @full_minute >= 41 && @full_second > 57 || @full_hour >= 4 && @full_minute >= 49 && 17 >= @full_second || @full_hour >= 4 && @full_minute >= 42
                     2
                   elsif @full_hour >= 4 && @full_minute >= 34 && @full_second > 59 || @full_hour >= 4 && @full_minute >= 41 && 57 >= @full_second || @full_hour >= 4 && @full_minute >= 35
                     3
                   elsif @full_hour >= 4 && @full_minute >= 28 && @full_second > 22 || @full_hour >= 4 && @full_minute >= 34 && 59 >= @full_second || @full_hour >= 4 && @full_minute >= 29
                     4
                   elsif @full_hour >= 4 && @full_minute >= 22 && @full_second > 3 || @full_hour >= 4 && @full_minute >= 28 && 22 >= @full_second || @full_hour >= 4 && @full_minute >= 23
                     5
                   elsif @full_hour >= 4 && @full_minute >= 16 && @full_second > 3 || @full_hour >= 4 && @full_minute >= 22 && 3 >= @full_second || @full_hour >= 4 && @full_minute >= 17
                     6
                   elsif @full_hour >= 4 && @full_minute >= 10 && @full_second > 19 || @full_hour >= 4 && @full_minute >= 16 && 3 >= @full_second || @full_hour >= 4 && @full_minute >= 11
                     7
                   elsif @full_hour >= 4 && @full_minute >= 4 && @full_second > 50 || @full_hour >= 4 && @full_minute >= 10 && 19 >= @full_second || @full_hour >= 4 && @full_minute >= 5
                     8
                   elsif @full_hour >= 3 && @full_minute >= 59 && @full_second > 35 || @full_hour >= 4 && @full_minute >= 4 && 50 >= @full_second || @full_hour >= 4 && @full_minute >= 0
                     9
                   elsif @full_hour >= 3 && @full_minute >= 54 && @full_second > 34 || @full_hour >= 3 && @full_minute >= 59 && 35 >= @full_second || @full_hour >= 3 && @full_minute >= 55
                     10
                   elsif @full_hour >= 3 && @full_minute >= 49 && @full_second > 45 || @full_hour >= 3 && @full_minute >= 54 && 34 >= @full_second || @full_hour >= 3 && @full_minute >= 50
                     11
                   elsif @full_hour >= 3 && @full_minute >= 45 && @full_second > 9 || @full_hour >= 3 && @full_minute >= 49 && 45 >= @full_second || @full_hour >= 3 && @full_minute >= 46
                     12
                   elsif @full_hour >= 3 && @full_minute >= 40 && @full_second > 43 || @full_hour >= 3 && @full_minute >= 45 && 9 >= @full_second || @full_hour >= 3 && @full_minute >= 41
                     13
                   elsif @full_hour >= 3 && @full_minute >= 36 && @full_second > 28 || @full_hour >= 3 && @full_minute >= 40 && 43 >= @full_second || @full_hour >= 3 && @full_minute >= 37
                     14
                   elsif @full_hour >= 3 && @full_minute >= 32 && @full_second > 23 || @full_hour >= 3 && @full_minute >= 36 && 28 >= @full_second || @full_hour >= 3 && @full_minute >= 33
                     15
                   elsif @full_hour >= 3 && @full_minute >= 28 && @full_second > 26 || @full_hour >= 3 && @full_minute >= 32 && 23 >= @full_second || @full_hour >= 3 && @full_minute >= 29
                     16
                   elsif @full_hour >= 3 && @full_minute >= 24 && @full_second > 39 || @full_hour >= 3 && @full_minute >= 28 && 26 >= @full_second || @full_hour >= 3 && @full_minute >= 25
                     17
                   elsif @full_hour >= 3 && @full_minute >= 21 && @full_second > 0 || @full_hour >= 3 && @full_minute >= 24 && 39 >= @full_second || @full_hour >= 3 && @full_minute >= 22
                     18
                   elsif @full_hour >= 3 && @full_minute >= 17 && @full_second > 29 || @full_hour >= 3 && @full_minute >= 21 && 0 >= @full_second || @full_hour >= 3 && @full_minute >= 18
                     19
                   elsif @full_hour >= 3 && @full_minute >= 14 && @full_second > 6 || @full_hour >= 3 && @full_minute >= 17 && 29 >= @full_second || @full_hour >= 3 && @full_minute >= 15
                     20
                   elsif @full_hour >= 3 && @full_minute >= 10 && @full_second > 49 || @full_hour >= 3 && @full_minute >= 14 && 6 >= @hfull_second || @full_hour >= 3 && @full_minute >= 11
                     21
                   elsif @full_hour >= 3 && @full_minute >= 7 && @full_second > 39 || @full_hour >= 3 && @full_minute >= 10 && 49 >= @hfull_second || @full_hour >= 3 && @full_minute >= 8
                     22
                   elsif @full_hour >= 3 && @full_minute >= 4 && @full_second > 36 || @full_hour >= 3 && @full_minute >= 7 && 39 >= @hfull_second || @full_hour >= 3 && @full_minute >= 5
                     23
                   elsif @full_hour >= 3 && @full_minute >= 1 && @full_second > 39 || @full_hour >= 3 && @full_minute >= 4 && 36 >= @hfull_second || @full_hour >= 3 && @full_minute >= 2
                     24
                   else
                     25
                   end
    end
  end

  def target_record_and_pace    # 目指すべきベストタイムと推奨ペースを取得
    @vdot_record_five = VdotRecord.find(@five_vdot)
    @vdot_pace_five = VdotPace.find(@five_vdot)

    @vdot_record_ten = VdotRecord.find(@ten_vdot)
    @vdot_pace_ten = VdotPace.find(@ten_vdot)

    @vdot_record_half = VdotRecord.find(@half_vdot)
    @vdot_pace_half = VdotPace.find(@half_vdot)

    @vdot_record_full = VdotRecord.find(@full_vdot)
    @vdot_pace_full = VdotPace.find(@full_vdot)
  end

end