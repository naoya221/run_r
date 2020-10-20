class UsersController < ApplicationController
  include Vdots

  def show
    @user = User.find(params[:id])
    @tweets = @user.tweets.page(params[:page]).per(8).order('created_at DESC')

    get_record(params[:id])    # 各ベストタイムのレコードを取得
    get_five_vdot              # 登録してある5kmのベストタイムを元に、5kmのvdot（走力レベル）を取得
    get_ten_vdot               # 登録してある10kmのベストタイムを元に、10kmのvdot（走力レベル）を取得
    get_half_vdot              # 登録してあるハーフのベストタイムを元に、ハーフのvdot（走力レベル）を取得
    get_full_vdot              # 登録してあるフルのベストタイムを元に、フルのvdot（走力レベル）を取得
    target_record_and_pace     # 目指すべきベストタイムと推奨ペースを取得
    runner_level               # 走力に応じた称号を取得
  end

  def followings
    @user = User.find(params[:id])
    @users = @user.followings.page(params[:page]).per(5)
    render 'show_followings'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(5)
    render 'show_followers'
  end

  private

  def runner_level
    levels = [@five_vdot,
              @ten_vdot,
              @half_vdot,
              @full_vdot]

    max_vdot = levels.max

    if max_vdot >= 20
      @runner_level = '最強ランナー'
      @text = '市民ランナー上位5%の実力です！'
    elsif max_vdot >= 15
      @runner_level = 'プロランナー'
      @text = '市民ランナー上位20%の実力です！'
    elsif max_vdot >= 10
      @runner_level = 'ベテランランナー'
      @text = '市民ランナー上位40%の実力です！'
    elsif max_vdot >= 5
      @runner_level = 'アマチュアランナー'
      @text = '市民ランナー上位50%の実力です！'
    else
      @runner_level = '駆け出しランナー'
      @text = '市民ランナー上位60%の実力です！'
    end
  end
end
