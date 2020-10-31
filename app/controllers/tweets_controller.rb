class TweetsController < ApplicationController
  # 未ログイン者の制限
  before_action :authenticate_user!, except: [:index, :show, :search, :tag_search]

  # ログイン者に紐づくツイートの中から、idが（params[:id]）のツイートを探す
  before_action :set_current_tweet, only: [:destroy, :edit, :update]

  # 各ランニングコース（人気・初心者向け・経験者向け）を取得
  before_action :get_recommended_tweets, only: :index

  # ビューに表示するタグを取得（最大18個）
  before_action :get_tags, only: [:index, :search, :tag_search]

  def index
    @tweets = Tweet.includes(:user).page(params[:page]).per(8).order('created_at DESC')
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)
    tag_list = params[:tweet][:tag_ids].split(',')
    if @tweet.save
      @tweet.save_tags(tag_list)
      redirect_to root_path, notice: '投稿しました！'
    else
      render :new
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    @tweet_messages = @tweet.messages.includes(:user).order('created_at DESC')
    @random = Tweet.order('RAND()').limit(7)
    @tweet_tags = @tweet.tags
  end

  def destroy
    if @tweet.destroy
      redirect_to root_path, notice: '投稿を削除しました！'
    else
      render :show
    end
  end

  def edit
    @tag_list = @tweet.tags.pluck(:name).join(',')
  end

  def update
    tag_list = params[:tweet][:tag_ids].split(',')
    if @tweet.update(tweet_params)
      @tweet.save_tags(tag_list)
      redirect_to root_path, notice: '投稿を編集しました！'
    else
      render :edit
    end
  end

  def search
    @tweets = Tweet.search(params[:keyword]).page(params[:page]).per(8).order('created_at DESC')
  end

  def tag_search
    @tag = Tag.find(params[:tag_id])
    @tweets = @tag.tweets.all.page(params[:page]).per(8).order('created_at DESC')
  end

  private

  # ログイン者に紐づくツイートの中から、idが（params[:id]）のツイートを探す
  def set_current_tweet
    @tweet = current_user.tweets.find(params[:id])
  end

  # 外部入力を許可したカラム
  def tweet_params
    params.require(:tweet).permit(
      :content, :address, :longitude, :latitude, :place_name, :place_image, :level
    )
  end

  # 各ランニングコース（人気・初心者向け・経験者向け）を取得
  def get_recommended_tweets
    tweets_ranking_sort = Tweet.all.sort { |a, b| b.liked_users.count <=> a.liked_users.count}
    tweets_ranking = tweets_ranking_sort[0..3]
    tweets_beginner = Tweet.where(level: 1).order('RAND()').limit(4)
    tweets_senior = Tweet.where(level: 2).order('RAND()').limit(4)
    @recommended_tweets = [tweets_ranking, tweets_beginner, tweets_senior]
  end

  # ビューに表示するタグを取得（最大18個）
  def get_tags
    @tag_lists = Tag.all.order('RAND()').limit(18)
  end
end
