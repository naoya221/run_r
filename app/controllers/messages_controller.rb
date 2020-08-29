class MessagesController < ApplicationController
    
  def create
    @message = Message.new(text: params[:text], user_id: current_user.id, tweet_id: params[:tweet_id])
    if @message.save
      ActionCable.server.broadcast 'message_channel', content: @message
    end
  end
end
