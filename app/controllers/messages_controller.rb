class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @message = Message.new(text: params[:text], user_id: current_user.id, tweet_id: params[:tweet_id])
    if @message.save
      ActionCable.server.broadcast 'message_channel', content: @message

      @tweet=@message.tweet
      @tweet.create_notification_message!(current_user, @message.id)
    end
  end
end
