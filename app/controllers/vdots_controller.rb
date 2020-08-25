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
      end
      if @ten_vdot.present?
        @vdot_record_ten = VdotRecord.find(@ten_vdot)
      end
      if @half_vdot.present?
        @vdot_record_half = VdotRecord.find(@half_vdot)
      end
      if @full_vdot.present?
        @vdot_record_full = VdotRecord.find(@full_vdot)
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
      if @five_minute >= 29 && @five_second > 51
        @five_vdot = 0
      elsif @five_minute >= 29 && @five_second > 5
        @five_vdot = 1
      elsif @five_minute >= 28 && @five_second > 21
        @five_vdot = 2
      elsif @five_minute >= 27 && @five_second > 39
        @five_vdot = 3  
      elsif @five_minute >= 27 && @five_second > 0
        @five_vdot = 4
      elsif @five_minute >= 26 && @five_second > 22
        @five_vdot = 5
      elsif @five_minute >= 25 && @five_second > 46
        @five_vdot = 6
      elsif @five_minute >= 25 && @five_second > 12
        @five_vdot = 7
      elsif @five_minute >= 24 && @five_second > 39
        @five_vdot = 8
      else  
        @five_vdot = 5
      end
    end 
  end

  def user_ten_record
    if TenKmRecord.where(user_id: params[:user_id]).present?
      if @ten_minute >= 62 && @ten_second > 03
        @ten_vdot = 0
      elsif @ten_minute >= 60 && @ten_second > 26
        @ten_vdot = 1
      elsif @ten_minute >= 58 && @ten_second > 54
        @ten_vdot = 2
      elsif @ten_minute >= 57 && @ten_second > 26
        @ten_vdot = 3
      elsif @ten_minute >= 56 && @ten_second > 3
        @ten_vdot = 4
      elsif @ten_minute >= 54 && @ten_second > 44
        @ten_vdot = 5
      elsif @ten_minute >= 53 && @ten_second > 29
        @ten_vdot = 6
      elsif @ten_minute >= 52 && @ten_second > 17
        @ten_vdot = 7
      elsif @ten_minute >= 51 && @ten_second > 9
        @ten_vdot = 8
      else  
        @ten_vdot = 4
      end
    end
  end

  def user_half_record
    if HalfRecord.where(user_id: params[:user_id]).present?
      if @half_hour >= 2 && @half_minute >= 17 && @half_second > 21
        @half_vdot = 0
      elsif @half_hour >= 2 && @half_minute >= 13 && @half_second > 49
        @half_vdot = 1
      elsif @half_hour >= 2 && @half_minute >= 10 && @half_second > 27
        @half_vdot = 2
      elsif @half_hour >= 2 && @half_minute >= 7 && @half_second > 16
        @half_vdot = 3  
      elsif @half_hour >= 2 && @half_minute >= 4 && @half_second > 13
        @half_vdot = 4
      elsif @half_hour >= 2 && @half_minute >= 1 && @half_second > 19
        @half_vdot = 5
      elsif @half_hour >= 1 && @half_minute >= 58 && @half_second > 34
        @half_vdot = 6
      elsif @half_hour >= 1 && @half_minute >= 55 && @half_second > 55
        @half_vdot = 7
      elsif @half_hour >= 1 && @half_minute >= 53 && @half_second > 24
        @half_vdot = 8
      else  
        @half_vdot = 6
      end
    end
  end

  def user_full_record
    if FullRecord.where(user_id: params[:user_id]).present?
      if @full_hour >= 4 && @full_minute >= 41 && @full_second > 57
        @full_vdot = 0
      elsif @full_hour >= 4 && @full_minute >= 41 && @full_second > 57
        @full_vdot = 1
      elsif @full_hour >= 4 && @full_minute >= 41 && @full_second > 57
        @full_vdot = 2
      elsif @full_hour >= 4 && @full_minute >= 41 && @full_second > 57
        @full_vdot = 3  
      elsif @full_hour >= 4 && @full_minute >= 41 && @full_second > 57
        @full_vdot = 4
      elsif @full_hour >= 4 && @full_minute >= 41 && @full_second > 57
        @full_vdot = 5
      elsif @full_hour >= 4 && @full_minute >= 41 && @full_second > 57
        @full_vdot = 6
      elsif @full_hour >= 4 && @full_minute >= 41 && @full_second > 57
        @full_vdot = 7
      elsif @full_hour >= 4 && @full_minute >= 41 && @full_second > 57
        @full_vdot = 8
      else  
        @full_vdot = 4
      end
    end
  end

end
