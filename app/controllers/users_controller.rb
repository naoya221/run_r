class UsersController < ApplicationController
  # 走力レベルの取得などまとめてある
  include Vdots

  def show
    @user = User.find(params[:id])
    # 選択したユーザーによる、コース投稿を全て取得。コースが8つでページネーション
    @tweets = @user.tweets.includes([:likes, :messages]).page(params[:page]).per(8).order('created_at DESC')

    # 各ベストタイムのレコードを取得
    get_record(params[:id])

    # 登録してある5kmのベストタイムを元に、5kmのvdot（走力レベル）を取得
    get_five_vdot

    # 登録してある10kmのベストタイムを元に、10kmのvdot（走力レベル）を取得
    get_ten_vdot

    # 登録してあるハーフのベストタイムを元に、ハーフのvdot（走力レベル）を取得
    get_half_vdot

    # 登録してあるフルのベストタイムを元に、フルのvdot（走力レベル）を取得
    get_full_vdot

    # 目指すべきベストタイムと推奨ペースを取得
    target_record_and_pace

    # 走力に応じた称号を取得
    runner_title
  end

  private

  # 走力に応じた称号を取得
  def runner_title
    vdots = [@five_vdot, @ten_vdot, @half_vdot, @full_vdot]
    max_vdot = vdots.max

    # 最大走力レベルに対応する称号を取得
    # (計算方法)          5 - (最大走力レベル ÷5 )(端数切捨て) ただし0より小さくはならないようにする
    @runner_level_num = [5 - (max_vdot / 5).to_i, 0].max
  end
end
