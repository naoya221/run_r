class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications
    #通知画面を開くとcheckedをtrueにして通知確認済にする
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

  def destroy
      @notifications =current_user.passive_notifications.destroy_all
      redirect_to notifications_path
  end
end
