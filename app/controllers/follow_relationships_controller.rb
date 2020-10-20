class FollowRelationshipsController < ApplicationController
  def create
    @user = User.find(params[:follow_relationship][:following_id])
    current_user.follow(@user)
    @user.create_notification_follow!(current_user)
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_url)}
      format.js
    end
  end

  def destroy
    @user = User.find(params[:follow_relationship][:following_id])
    current_user.unfollow(@user)
    respond_to do |format|
      format.html {redirect_back(fallback_location: root_url)}
      format.js
    end
  end
end
