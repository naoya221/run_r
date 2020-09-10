class TweetsController < ApplicationController
  before_action :set_params, only: [:show, :destroy, :edit, :update]
  before_action :move_to_index, only: [:destroy, :edit, :update]
  before_action :authenticate_user!, except: [:index, :show, :search]

  def index
    @tweets = Tweet.includes(:user).page(params[:page]).per(8).order('created_at DESC')
    @user = User.find(current_user.id) if user_signed_in?
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      flash[:notice] = '　　　　投稿しました！　　　　'
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
      flash[:notice] = '　　　投稿を削除しました！　　　'
      redirect_to root_path
    else
      render :show
    end
  end

  def edit
  end

  def update
    if @tweet.update(tweet_params)
      flash[:notice] = '　　　投稿を編集しました！　　　'
      redirect_to root_path
    else
      render :edit
    end
  end

  def search
    @tweets = Tweet.search(params[:keyword]).page(params[:page]).per(8).order('created_at DESC')
    @user = User.find(current_user.id) if user_signed_in?
  end

  private

  def set_params
    @tweet = Tweet.find(params[:id])
  end

  def move_to_index
    redirect_to root_path if @tweet.user_id != current_user.id
  end

  def tweet_params
    params.require(:tweet).permit(:content, :address, :longitude, :latitude, :place_name, :place_image).merge(user_id: current_user.id)
  end
end
