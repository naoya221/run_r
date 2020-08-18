class RecordsController < ApplicationController

  def new
    @five_km_record = FiveKmRecord.new
  end

end
