class VdotsController < ApplicationController

  def index
    @vdot_records = VdotRecord.all
    @vdot_paces = VdotPace.all

    if (params[:user_id]).present?
      record_sum()
      user_five_record()
      user_ten_record()
      user_half_record()
      user_full_record()
    
      @user = User.find(params[:user_id])

      if @five_vdot.present?
        @vdot_record_five = VdotRecord.find(@five_vdot)
        @vdot_pace_five = VdotPace.find(@five_vdot)
      end
      if @ten_vdot.present?
        @vdot_record_ten = VdotRecord.find(@ten_vdot)
        @vdot_pace_ten = VdotPace.find(@ten_vdot)
      end
      if @half_vdot.present?
        @vdot_record_half = VdotRecord.find(@half_vdot)
        @vdot_pace_half = VdotPace.find(@half_vdot)
      end
      if @full_vdot.present?
        @vdot_record_full = VdotRecord.find(@full_vdot)
        @vdot_pace_full = VdotPace.find(@full_vdot)
      end
      

    end
  end
    

  private

  def record_sum

    if FiveKmRecord.where(user_id: params[:user_id]).present?
      five_record = FiveKmRecord.where(user_id: params[:user_id])
      five_record = five_record.ids
      five_record = FiveKmRecord.find(five_record[0])
      @five_minute = five_record.minute[:name].to_i 
      @five_second = five_record.second[:name].to_i
    end  

    if TenKmRecord.where(user_id: params[:user_id]).present?
      ten_record = TenKmRecord.where(user_id: params[:user_id])
      ten_record = ten_record.ids
      ten_record = TenKmRecord.find(ten_record[0])
      @ten_minute = ten_record.minute[:name].to_i
      @ten_second = ten_record.second[:name].to_i
    end
    
    if HalfRecord.where(user_id: params[:user_id]).present?
      half_record = HalfRecord.where(user_id: params[:user_id])
      half_record = half_record.ids
      half_record = HalfRecord.find(half_record[0])
      @half_hour = half_record.hour[:name].to_i
      @half_minute = half_record.minute[:name].to_i
      @half_second = half_record.second[:name].to_i
    end
    
    if FullRecord.where(user_id: params[:user_id]).present?
      full_record = FullRecord.where(user_id: params[:user_id])
      full_record = full_record.ids
      full_record = FullRecord.find(full_record[0])
      @full_hour = full_record.hour[:name].to_i
      @full_minute = full_record.minute[:name].to_i
      @full_second = full_record.second[:name].to_i
    end

  end

  def user_five_record
    if FiveKmRecord.where(user_id: params[:user_id]).present?
      if @five_minute >= 30 && @five_second > 40 || @five_minute >= 31 
        @five_vdot = 0
      elsif @five_minute >= 29 && @five_second > 51 || @five_minute >= 30 && 40 >= @five_second
        @five_vdot = 1
      elsif @five_minute >= 29 && @five_second > 5
        @five_vdot = 2
      elsif @five_minute >= 28 && @five_second > 21 || @five_minute >= 29 && 5 >= @five_second
        @five_vdot = 3
      elsif @five_minute >= 27 && @five_second > 39 || @five_minute >= 28 && 21 >= @five_second
        @five_vdot = 4 
      elsif @five_minute >= 27 && @five_second > 0
        @five_vdot = 5
      elsif @five_minute >= 26 && @five_second > 22
        @five_vdot = 6
      elsif @five_minute >= 25 && @five_second > 46 || @five_minute >= 26 && 22 >= @five_second
        @five_vdot = 7
      elsif @five_minute >= 25 && @five_second > 12
        @five_vdot = 8
      elsif @five_minute >= 24 && @five_second > 39 || @five_minute >= 25 && 12 >= @five_second
        @five_vdot = 9
      elsif @five_minute >= 24 && @five_second > 8
        @five_vdot = 10
      elsif @five_minute >= 23 && @five_second > 38 || @five_minute >= 24 && 8 >= @five_second
        @five_vdot = 11
      elsif @five_minute >= 23 && @five_second > 9
        @five_vdot = 12
      elsif @five_minute >= 22 && @five_second > 41 || @five_minute >= 23 && 9 >= @five_second
        @five_vdot = 13
      elsif @five_minute >= 22 && @five_second > 15
        @five_vdot = 14
      elsif @five_minute >= 21 && @five_second > 50 || @five_minute >= 22 && 15 >= @five_second
        @five_vdot = 15
      elsif @five_minute >= 21 && @five_second > 25
        @five_vdot = 16
      elsif @five_minute >= 21 && @five_second > 2
        @five_vdot = 17
      elsif @five_minute >= 20 && @five_second > 39 || @five_minute >= 21 && 2 >= @five_second
        @five_vdot = 18
      elsif @five_minute >= 20 && @five_second > 18
        @five_vdot = 19
      elsif @five_minute >= 19 && @five_second > 57 || @five_minute >= 20 && 18 >= @five_second
        @five_vdot = 20
      elsif @five_minute >= 19 && @five_second > 36
        @five_vdot = 21
      elsif @five_minute >= 19 && @five_second > 17
        @five_vdot = 22
      elsif @five_minute >= 18 && @five_second > 58 || @five_minute >= 19 && 17 >= @five_second
        @five_vdot = 23
      else  
        @five_vdot = 24
      end
    end 
  end

  def user_ten_record
    if TenKmRecord.where(user_id: params[:user_id]).present?
      if @ten_minute >= 63 && @ten_second > 46 || @ten_minute >= 64
        @ten_vdot = 0
      elsif @ten_minute >= 62 && @ten_second > 3 || @ten_minute >= 63 && 46 >= @ten_second
        @ten_vdot = 1
      elsif @ten_minute >= 60 && @ten_second > 26 || @ten_minute >= 62 && 3 >= @ten_second || @ten_minute == 61
        @ten_vdot = 2
      elsif @ten_minute >= 58 && @ten_second > 54 || @ten_minute >= 60 && 26 >= @ten_second || @ten_minute == 59
        @ten_vdot = 3
      elsif @ten_minute >= 57 && @ten_second > 26 || @ten_minute >= 58 && 54 >= @ten_second
        @ten_vdot = 4
      elsif @ten_minute >= 56 && @ten_second > 3 || @ten_minute >= 57 && 26 >= @ten_second
        @ten_vdot = 5
      elsif @ten_minute >= 54 && @ten_second > 44 || @ten_minute >= 56 && 3 >= @ten_second || @ten_minute >= 55
        @ten_vdot = 6
      elsif @ten_minute >= 53 && @ten_second > 29 || @ten_minute >= 54 && 46 >= @ten_second
        @ten_vdot = 7
      elsif @ten_minute >= 52 && @ten_second > 17 || @ten_minute >= 53 && 29 >= @ten_second
        @ten_vdot = 8
      elsif @ten_minute >= 51 && @ten_second > 9 || @ten_minute >= 52 && 17 >= @ten_second
        @ten_vdot = 9
    
      elsif @ten_minute >= 50 && @ten_second > 3 || @ten_minute >= 51 && 9 >= @ten_second
        @ten_vdot = 10
      elsif @ten_minute >= 49 && @ten_second > 1 || @ten_minute >= 50 && 3 >= @ten_second
        @ten_vdot = 11
      elsif @ten_minute >= 48 && @ten_second > 1 || @ten_minute >= 49 && 1 >= @ten_second
        @ten_vdot = 12
      elsif @ten_minute >= 47 && @ten_second > 4 || @ten_minute >= 48 && 1 >= @ten_second
        @ten_vdot = 13
      elsif @ten_minute >= 46 && @ten_second > 9 || @ten_minute >= 47 && 4 >= @ten_second
        @ten_vdot = 14
      elsif @ten_minute >= 45 && @ten_second > 16 || @ten_minute >= 46 && 9 >= @ten_second
        @ten_vdot = 15
      elsif @ten_minute >= 44 && @ten_second > 25 || @ten_minute >= 45 && 16 >= @ten_second
        @ten_vdot = 16
      elsif @ten_minute >= 43 && @ten_second > 36 || @ten_minute >= 44 && 25 >= @ten_second
        @ten_vdot = 17
      elsif @ten_minute >= 42 && @ten_second > 50 || @ten_minute >= 43 && 36 >= @ten_second
        @ten_vdot = 18
      elsif @ten_minute >= 42 && @ten_second > 4
        @ten_vdot = 19

      elsif @ten_minute >= 41 && @ten_second > 21 || @ten_minute >= 42 && 4 >= @ten_second
        @ten_vdot = 20
      elsif @ten_minute >= 40 && @ten_second > 39 || @ten_minute >= 41 && 21 >= @ten_second
        @ten_vdot = 21
      elsif @ten_minute >= 39 && @ten_second > 59 || @ten_minute >= 40 && 39 >= @ten_second
        @ten_vdot = 22
      elsif @ten_minute >= 39 && @ten_second > 20
        @ten_vdot = 23
      else  
        @ten_vdot = 24
      end
    end
  end

  def user_half_record
    if HalfRecord.where(user_id: params[:user_id]).present?
      if @half_hour >= 2 && @half_minute >= 21 && @half_second > 4 || @half_hour == 2 && @half_minute >= 22 || @half_hour >= 3
        @half_vdot = 0
      elsif @half_hour >= 2 && @half_minute >= 17 && @half_second > 21 || @half_hour >= 2 && @half_minute >= 21 && 4 >= @half_second || @half_hour >= 2 && @half_minute >= 18
        @half_vdot = 1
      elsif @half_hour >= 2 && @half_minute >= 13 && @half_second > 49 || @half_hour >= 2 && @half_minute >= 17 && 21 >= @half_second || @half_hour >= 2 && @half_minute >= 14
        @half_vdot = 2
      elsif @half_hour >= 2 && @half_minute >= 10 && @half_second > 27 || @half_hour >= 2 && @half_minute >= 13 && 49 >= @half_second || @half_hour >= 2 && @half_minute >= 11
        @half_vdot = 3
      elsif @half_hour >= 2 && @half_minute >= 7 && @half_second > 16 || @half_hour >= 2 && @half_minute >= 10 && 27 >= @half_second || @half_hour >= 2 && @half_minute >= 8
        @half_vdot = 4  
      elsif @half_hour >= 2 && @half_minute >= 4 && @half_second > 13 || @half_hour >= 2 && @half_minute >= 7 && 16 >= @half_second || @half_hour >= 2 && @half_minute >= 5
        @half_vdot = 5
      elsif @half_hour >= 2 && @half_minute >= 1 && @half_second > 19 || @half_hour >= 2 && @half_minute >= 4 && 13 >= @half_second || @half_hour >= 2 && @half_minute >= 2
        @half_vdot = 6
      elsif @half_hour >= 1 && @half_minute >= 58 && @half_second > 34 || @half_hour >= 2 && @half_minute >= 1 && 19 >= @half_second || @half_hour >= 2 && @half_minute == 0 || @half_hour >= 1 && @half_minute >= 59
        @half_vdot = 7
      elsif @half_hour >= 1 && @half_minute >= 55 && @half_second > 55 || @half_hour >= 1 && @half_minute >= 58 && 34 >= @half_second || @half_hour >= 1 && @half_minute >= 56
        @half_vdot = 8
      elsif @half_hour >= 1 && @half_minute >= 53 && @half_second > 24 || @half_hour >= 1 && @half_minute >= 55 && 55 >= @half_second || @half_hour >= 1 && @half_minute >= 54
        @half_vdot = 9
      elsif @half_hour >= 1 && @half_minute >= 50 && @half_second > 59 || @half_hour >= 1 && @half_minute >= 53 && 24 >= @half_second || @half_hour >= 1 && @half_minute >= 51
        @half_vdot = 10
      elsif @half_hour >= 1 && @half_minute >= 48 && @half_second > 40 || @half_hour >= 1 && @half_minute >= 50 && 59 >= @half_second || @half_hour >= 1 && @half_minute >= 49
        @half_vdot = 11
      elsif @half_hour >= 1 && @half_minute >= 46 && @half_second > 27 || @half_hour >= 1 && @half_minute >= 48 && 40 >= @half_second || @half_hour >= 1 && @half_minute >= 47
        @half_vdot = 12
      elsif @half_hour >= 1 && @half_minute >= 44 && @half_second > 20 || @half_hour >= 1 && @half_minute >= 46 && 27 >= @half_second || @half_hour >= 1 && @half_minute >= 45
        @half_vdot = 13
      elsif @half_hour >= 1 && @half_minute >= 42 && @half_second > 17 || @half_hour >= 1 && @half_minute >= 44 && 20 >= @half_second || @half_hour >= 1 && @half_minute >= 43
        @half_vdot = 14
      elsif @half_hour >= 1 && @half_minute >= 40 && @half_second > 20 || @half_hour >= 1 && @half_minute >= 42 && 17 >= @half_second || @half_hour >= 1 && @half_minute >= 41
        @half_vdot = 15
      elsif @half_hour >= 1 && @half_minute >= 38 && @half_second > 27 || @half_hour >= 1 && @half_minute >= 40 && 20 >= @half_second || @half_hour >= 1 && @half_minute >= 39
        @half_vdot = 16
      elsif @half_hour >= 1 && @half_minute >= 36 && @half_second > 38 || @half_hour >= 1 && @half_minute >= 38 && 27 >= @half_second || @half_hour >= 1 && @half_minute >= 37
        @half_vdot = 17
      elsif @half_hour >= 1 && @half_minute >= 34 && @half_second > 53 || @half_hour >= 1 && @half_minute >= 36 && 38 >= @half_second || @half_hour >= 1 && @half_minute >= 35
        @half_vdot = 18
      elsif @half_hour >= 1 && @half_minute >= 33 && @half_second > 12 || @half_hour >= 1 && @half_minute >= 34 && 53 >= @half_second
        @half_vdot = 19
      elsif @half_hour >= 1 && @half_minute >= 31 && @half_second > 35 || @half_hour >= 1 && @half_minute >= 33 && 12 >= @half_second || @half_hour >= 1 && @half_minute >= 32
        @half_vdot = 20
      elsif @half_hour >= 1 && @half_minute >= 30 && @half_second > 2 || @half_hour >= 1 && @half_minute >= 31 && 35 >= @half_second
        @half_vdot = 21
      elsif @half_hour >= 1 && @half_minute >= 28 && @half_second > 31 || @half_hour >= 1 && @half_minute >= 30 && 2 >= @half_second || @half_hour >= 1 && @half_minute >= 29
        @half_vdot = 22
      elsif @half_hour >= 1 && @half_minute >= 27 && @half_second > 4 || @half_hour >= 1 && @half_minute >= 28 && 31 >= @half_second
        @half_vdot = 23
      else  
        @half_vdot = 24
      end
    end
  end

  def user_full_record
    if FullRecord.where(user_id: params[:user_id]).present?
      if @full_hour >= 4 && @full_minute >= 49 && @full_second > 17 || @full_hour == 4 && @full_minute >= 50 || @full_hour >= 5
        @full_vdot = 0
      elsif @full_hour >= 4 && @full_minute >= 41 && @full_second > 57 || @full_hour >= 4 && @full_minute >= 49 && 17 >= @full_second || @full_hour >= 4 && @full_minute >= 42
        @full_vdot = 1
      elsif @full_hour >= 4 && @full_minute >= 34 && @full_second > 59 || @full_hour >= 4 && @full_minute >= 41 && 57 >= @full_second || @full_hour >= 4 && @full_minute >= 35
        @full_vdot = 2
      elsif @full_hour >= 4 && @full_minute >= 28 && @full_second > 22 || @full_hour >= 4 && @full_minute >= 34 && 59 >= @full_second || @full_hour >= 4 && @full_minute >= 29
        @full_vdot = 3
      elsif @full_hour >= 4 && @full_minute >= 22 && @full_second > 3 || @full_hour >= 4 && @full_minute >= 28 && 22 >= @full_second || @full_hour >= 4 && @full_minute >= 23
        @full_vdot = 4  
      elsif @full_hour >= 4 && @full_minute >= 16 && @full_second > 3 || @full_hour >= 4 && @full_minute >= 22 && 3 >= @full_second || @full_hour >= 4 && @full_minute >= 17
        @full_vdot = 5
      elsif @full_hour >= 4 && @full_minute >= 10 && @full_second > 19 || @full_hour >= 4 && @full_minute >= 16 && 3 >= @full_second || @full_hour >= 4 && @full_minute >= 11
        @full_vdot = 6
      elsif @full_hour >= 4 && @full_minute >= 4 && @full_second > 50 || @full_hour >= 4 && @full_minute >= 10 && 19 >= @full_second || @full_hour >= 4 && @full_minute >= 5
        @full_vdot = 7
      elsif @full_hour >= 3 && @full_minute >= 59 && @full_second > 35 || @full_hour >= 4 && @full_minute >= 4 && 50 >= @full_second || @full_hour >= 4 && @full_minute >= 0
        @full_vdot = 8
      elsif @full_hour >= 3 && @full_minute >= 54 && @full_second > 34 || @full_hour >= 3 && @full_minute >= 59 && 35 >= @full_second || @full_hour >= 3 && @full_minute >= 55
        @full_vdot = 9
      elsif @full_hour >= 3 && @full_minute >= 49 && @full_second > 45 || @full_hour >= 3 && @full_minute >= 54 && 34 >= @full_second || @full_hour >= 3 && @full_minute >= 50
        @full_vdot = 10
      elsif @full_hour >= 3 && @full_minute >= 45 && @full_second > 9 || @full_hour >= 3 && @full_minute >= 49 && 45 >= @full_second || @full_hour >= 3 && @full_minute >= 46
        @full_vdot = 11
      elsif @full_hour >= 3 && @full_minute >= 40 && @full_second > 43 || @full_hour >= 3 && @full_minute >= 45 && 9 >= @full_second || @full_hour >= 3 && @full_minute >= 41
        @full_vdot = 12
      elsif @full_hour >= 3 && @full_minute >= 36 && @full_second > 28 || @full_hour >= 3 && @full_minute >= 40 && 43 >= @full_second || @full_hour >= 3 && @full_minute >= 37
        @full_vdot = 13
      elsif @full_hour >= 3 && @full_minute >= 32 && @full_second > 23 || @full_hour >= 3 && @full_minute >= 36 && 28 >= @full_second || @full_hour >= 3 && @full_minute >= 33
        @full_vdot = 14
      elsif @full_hour >= 3 && @full_minute >= 28 && @full_second > 26 || @full_hour >= 3 && @full_minute >= 32 && 23 >= @full_second || @full_hour >= 3 && @full_minute >= 29
        @full_vdot = 15
      elsif @full_hour >= 3 && @full_minute >= 24 && @full_second > 39 || @full_hour >= 3 && @full_minute >= 28 && 26 >= @full_second || @full_hour >= 3 && @full_minute >= 25
        @full_vdot = 16
      elsif @full_hour >= 3 && @full_minute >= 21 && @full_second > 0 || @full_hour >= 3 && @full_minute >= 24 && 39 >= @full_second || @full_hour >= 3 && @full_minute >= 22
        @full_vdot = 17
      elsif @full_hour >= 3 && @full_minute >= 17 && @full_second > 29 || @full_hour >= 3 && @full_minute >= 21 && 0 >= @full_second || @full_hour >= 3 && @full_minute >= 18
        @full_vdot = 18
      elsif @full_hour >= 3 && @full_minute >= 14 && @full_second > 6 || @full_hour >= 3 && @full_minute >= 17 && 29 >= @full_second || @full_hour >= 3 && @full_minute >= 15
        @full_vdot = 19
      elsif @full_hour >= 3 && @full_minute >= 10 && @full_second > 49 || @full_hour >= 3 && @full_minute >= 14 && 6 >= @hfull_second || @full_hour >= 3 && @full_minute >= 11
        @full_vdot = 20
      elsif @full_hour >= 3 && @full_minute >= 7 && @full_second > 39 || @full_hour >= 3 && @full_minute >= 10 && 49 >= @hfull_second || @full_hour >= 3 && @full_minute >= 8
        @full_vdot = 21
      elsif @full_hour >= 3 && @full_minute >= 4 && @full_second > 36 || @full_hour >= 3 && @full_minute >= 7 && 39 >= @hfull_second || @full_hour >= 3 && @full_minute >= 5
        @full_vdot = 22
      elsif @full_hour >= 3 && @full_minute >= 1 && @full_second > 39 || @full_hour >= 3 && @full_minute >= 4 && 36 >= @hfull_second || @full_hour >= 3 && @full_minute >= 2
        @full_vdot = 23
      else  
        @full_vdot = 24
      end
    end
  end

end
