class LikesController < ApplicationController
  # CSRFトークン検証をスキップ（非同期でいいねがされないため追記）
  skip_before_action :verify_authenticity_token

  # 選択されたツイートを取得
  before_action :get_params

  def create
    @like = Like.create(user_id: current_user.id, tweet_id: @tweet.id)
    @tweet.create_notification_like!(current_user)
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, tweet_id: @tweet.id)
    @like.destroy
  end

  private

  # 選択されたツイートを取得
  def get_params
    @tweet = Tweet.find(params[:tweet_id])
  end
end
