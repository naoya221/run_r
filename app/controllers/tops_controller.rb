class TopsController < ApplicationController
  def index
    redirect_to controller: :tweets, action: :index if user_signed_in?
  end
end
