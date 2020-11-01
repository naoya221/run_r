class TweetsController < ApplicationController
  # 未ログイン者の制限
  before_action :authenticate_user!, except: [:index, :show, :search, :tag_search]

  # ログイン者に紐づくコース投稿の中から、idが（params[:id]）のものを探す
  before_action :set_current_tweet, only: [:destroy, :edit, :update]

  # 各ランニングコース（人気・初心者向け・経験者向け）を取得
  before_action :get_recommended_tweets, only: :index

  # ビューに表示するタグを取得（最大18個）
  before_action :get_tags, only: [:index, :search, :tag_search]

  def index
    # コースを全て取得。コースが8つでページネーション
    @tweets = Tweet.includes(:user).page(params[:page]).per(8).order('created_at DESC')
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = current_user.tweets.new(tweet_params)

    # タグを作成（ , で複数作成可能）
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

    # 選択したコースへのコメントを取得
    @tweet_messages = @tweet.messages.includes(:user).order('created_at DESC')

    # 他のコース（関連コース的な）として7つ表示
    @random = Tweet.order('RAND()').limit(7)

    # 選択したコースに付与されているタグを取得
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
    # 選択したコースに付与されているタグを取得
    @tag_list = @tweet.tags.pluck(:name).join(',')
  end

  def update
    # 選択したコースに付与されているタグを取得
    tag_list = params[:tweet][:tag_ids].split(',')
    if @tweet.update(tweet_params)
      @tweet.save_tags(tag_list)
      redirect_to root_path, notice: '投稿を編集しました！'
    else
      render :edit
    end
  end

  # 検索ワードを含むコースを全て取得。コースが8つでページネーション
  # ※検索対象のカラムはtweetモデルのメソッドに設定してある
  def search
    @tweets = Tweet.search(params[:keyword]).page(params[:page]).per(8).order('created_at DESC')
  end

  # 選択したタグを含むコースを全て取得。コースが8つでページネーション
  def tag_search
    @tag = Tag.find(params[:tag_id])
    @tweets = @tag.tweets.all.page(params[:page]).per(8).order('created_at DESC')
  end

  private

  # ログイン者に紐づくコース投稿の中から、idが（params[:id]）のものを探す
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
    # いいねが最も多い順に、投稿を4つ取得
    tweets_ranking_sort = Tweet.all.sort { |a, b| b.liked_users.count <=> a.liked_users.count}
    tweets_ranking = tweets_ranking_sort[0..3]

    # 初心者向けのコースをランダムに4つ取得
    tweets_beginner = Tweet.where(level: 1).order('RAND()').limit(4)

    # 経験者向けのコースをランダムに4つ取得
    tweets_senior = Tweet.where(level: 2).order('RAND()').limit(4)

    # 上記3つを配列にまとめる
    # ※ビューでeachメソッドを使うため
    @recommended_tweets = [tweets_ranking, tweets_beginner, tweets_senior]
  end

  # ビューに表示するタグを取得（最大18個）
  def get_tags
    @tag_lists = Tag.all.order('RAND()').limit(18)
  end
end
