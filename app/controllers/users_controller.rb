class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @nickname = @user.nickname
    @tweets = @user.tweets
    @five_km_record = FiveKmRecord.find(params[:id])
    @ten_km_record = TenKmRecord.find(params[:id])
    @half_record = HalfRecord.find(params[:id])
    @full_record = FullRecord.find(params[:id])
  end
end
