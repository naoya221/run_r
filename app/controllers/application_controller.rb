class ApplicationController < ActionController::Base
  protect_from_forgery except: [:destroy]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :request_path

  # 特定のアクションのみ、何か表示する際に使用
  def request_path
    @path = controller_path + '#' + action_name
    def @path.is(*str)
        str.map{|s| self.include?(s)}.include?(true)
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :image, :introduction])

    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :image, :introduction])
  end
end
