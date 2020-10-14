class VdotsController < ApplicationController
  include Vdots

  def index
    @vdot_records = VdotRecord.all
    @vdot_paces = VdotPace.all

    if user_signed_in?
      get_record(current_user.id)    # 各ベストタイムのレコードを取得
      get_five_vdot                  # 登録してある5kmのベストタイムを元に、5kmのvdot（走力レベル）を取得
      get_ten_vdot                   # 登録してある10kmのベストタイムを元に、10kmのvdot（走力レベル）を取得
      get_half_vdot                  # 登録してあるハーフのベストタイムを元に、ハーフのvdot（走力レベル）を取得
      get_full_vdot                  # 登録してあるフルのベストタイムを元に、フルのvdot（走力レベル）を取得
    end
  end

end
