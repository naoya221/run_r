class NotificationsController < ApplicationController
  def index
    # ログイン者の通知を表示
    @notifications = current_user.passive_notifications.includes([:visitor])
  end

  def destroy
    # ログイン者の通知を全て削除
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end
end
