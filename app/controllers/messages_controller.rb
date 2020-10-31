class MessagesController < ApplicationController
  # 未ログイン者の制限
  before_action :authenticate_user!

  def create
    @message = Message.new(text: params[:text], user_id: current_user.id, tweet_id: params[:tweet_id])
    if @message.save
      # 正常にコメントが保存されれば、非同期にてコメントを表示
      ActionCable.server.broadcast 'message_channel', content: @message

      # コメントされたツイートを取得
      @tweet = @message.tweet

      # 上記に対する通知を作成
      @tweet.create_notification_message!(current_user, @message.id)
    end
  end
end
