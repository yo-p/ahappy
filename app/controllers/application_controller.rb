class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    #ログイン後のページをユーザーのshowページへ
    def after_sign_in_path_for(resource)
        user_path(resource)
    end
    #ログアウト後はログインページへ（トップページへ変更予定）
    def after_sign_out_path_for(resource)
        new_user_session_path
    end

    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email]) 
    end
end
