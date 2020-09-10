class MessageChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'message_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
