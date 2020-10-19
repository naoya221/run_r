class VdotsController < ApplicationController
  include Vdots

  def index
    @vdot_records = VdotRecord.all
    @vdot_paces = VdotPace.all
    @user = User.find_by(id: params[:user_id]) if params[:user_id]

    if params[:user_id]            # get_recordメソッドに渡す引数を分岐
      user_id = params[:user_id]
    elsif user_signed_in?
      user_id = current_user.id
    end

    get_record(user_id)            # 各ベストタイムのレコードを取得
    get_five_vdot                  # 登録してある5kmのベストタイムを元に、5kmの走力レベルを取得
    get_ten_vdot                   # 登録してある10kmのベストタイムを元に、10kmの走力レベルを取得
    get_half_vdot                  # 登録してあるハーフのベストタイムを元に、ハーフの走力レベルを取得
    get_full_vdot                  # 登録してあるフルのベストタイムを元に、フルの走力レベルを取得
  end

end
