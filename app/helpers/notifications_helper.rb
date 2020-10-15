module NotificationsHelper
  def notification_form(notification)
    #通知を送ってきたユーザーを取得
    @visitor = notification.visitor
    # #コメントの内容を通知に表示する
    # @comment = nil
    # @visitor_comment = notification.comment_id
    # notification.actionがfollowかlikeかcommentかで処理を変える
    case notification.action
    when 'follow'
      #aタグで通知を作成したユーザーshowのリンクを作成
      tag.a(notification.visitor.nickname, href: user_path(@visitor)) + 'があなたをフォローしました'
    when 'like'
      tag.a(notification.visitor.nickname, href: user_path(@visitor)) + 'が' + tag.a('あなたの投稿', href: tweet_path(notification.tweet_id)) + 'にいいねしました'
    end
  end
end
