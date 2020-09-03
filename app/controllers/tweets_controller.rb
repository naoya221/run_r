class TweetsController < ApplicationController
  before_action :set_params, only: [ :show, :destroy, :edit, :update]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @tweets = Tweet.includes(:user).order("created_at DESC")
    if user_signed_in?
      @user = User.find(current_user.id)
    end
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      flash[:notice_tweet_new] = "　　　　投稿しました！　　　　"
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @messages = Message.includes(:tweet, :user)
    @message = Message.new
  end

  def destroy
    if @tweet.destroy
      flash[:notice_tweet_destroy] = "　　　投稿を削除しました！　　　"
      redirect_to root_path
    else
      render :show
    end
  end

  def edit
  end

  def update
    if @tweet.update(tweet_params)
      flash[:notice_tweet_edit] = "　　　投稿を編集しました！　　　"
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def set_params
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:content,:address, :longitude, :latitude, :place_name, :place_image).merge(user_id: current_user.id)
  end

end
