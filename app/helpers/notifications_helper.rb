module NotificationsHelper
  def notification_form(notification)
    #通知を送ってきたユーザーを取得
    @visitor = notification.visitor
    # #コメントの内容を通知に表示する
    @message = nil
    @visitor_message = notification.message_id
    # notification.actionがfollowかlikeかcommentかで処理を変える
    case notification.action
    when 'follow'
      #aタグで通知を作成したユーザーshowのリンクを作成
      tag.a(notification.visitor.nickname, href: user_path(@visitor)) + 'があなたをフォローしました'
    when 'like'
      tag.a(notification.visitor.nickname, href: user_path(@visitor)) + 'が' + tag.a('あなたの投稿', href: tweet_path(notification.tweet_id)) + 'にいいねしました'
    when 'message' then
      #コメントの内容と投稿のタイトルを取得
      @message = Message.find_by(id: @visitor_message)
      tag.a(@visitor.nickname, href: user_path(@visitor)) + 'が' + tag.a("あなたの投稿", href: tweet_path(notification.tweet_id)) + 'にコメントしました'
    end
  end
end
