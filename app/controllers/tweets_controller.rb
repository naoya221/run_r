class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :set_current_tweet, only: [:destroy, :edit, :update]

  def index
    @tweets = Tweet.includes(:user).page(params[:page]).per(8).order('created_at DESC')
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)
    if @tweet.save
      redirect_to root_path, notice: '投稿しました！'
    else
      render :new
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    @tweet_messages = @tweet.messages.includes(:user).order(:created_at)
  end

  def destroy
    if @tweet.destroy
      redirect_to root_path, notice: '投稿を削除しました！'
    else
      render :show
    end
  end

  def edit
  end

  def update
    if @tweet.update(tweet_params)
      redirect_to root_path, notice: '投稿を編集しました！'
    else
      render :edit
    end
  end

  def search
    @tweets = Tweet.search(params[:keyword]).page(params[:page]).per(8).order('created_at DESC')
    @user = User.find(current_user.id) if user_signed_in?
  end

  private

  def set_current_tweet
    @tweet = current_user.tweets.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(
      :content, :address, :longitude, :latitude, :place_name, :place_image
    )
  end
end
