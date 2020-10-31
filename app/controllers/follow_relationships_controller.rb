class FollowRelationshipsController < ApplicationController
  def create
    # フォローされるユーザーを取得
    @user = User.find(params[:follow_relationship][:following_id])

    # ログイン者が@userをフォロー
    # ※followメソッドはuserモデルに定義
    current_user.follow(@user)

    # フォロー時の通知を作成
    @user.create_notification_follow!(current_user)

    # リクエストの種類によってフォロー時のレンダリングするビューを指定
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_url)}
      format.js
    end
  end

  def destroy
    # アンフォローされるユーザーを取得
    @user = User.find(params[:follow_relationship][:following_id])

    # ログイン者が@userをアンフォロー
    # ※unfollowメソッドはuserモデルに定義
    current_user.unfollow(@user)

    # アンフォロー時のレンダリングするビューを指定
    respond_to do |format|
      format.html {redirect_back(fallback_location: root_url)}
      format.js
    end
  end
end
