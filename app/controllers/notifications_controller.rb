class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications
  end

  def destroy
    @notifications = current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end
end
