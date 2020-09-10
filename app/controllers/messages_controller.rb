class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @message = Message.new(text: params[:text], user_id: current_user.id, tweet_id: params[:tweet_id])
    ActionCable.server.broadcast 'message_channel', content: @message if @message.save
  end
end
