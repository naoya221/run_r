class LikesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :get_params

  def create
    @like = Like.create(user_id: current_user.id, tweet_id: @tweet.id)
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, tweet_id: @tweet.id)
    @like.destroy
  end

  private

  def get_params
    @tweet = Tweet.find(params[:tweet_id])
  end
end
