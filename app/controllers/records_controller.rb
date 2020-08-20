class RecordsController < ApplicationController

  def new
    @user = User.find(current_user.id)
    
  end

  def edit
    @user = User.find(current_user.id)
  end

end
