class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    before_action :authenticate_user!, unless: :splash_screen_controller?
    before_action :update_allowed_parameters, if: :devise_controller?

    protected

    def update_allowed_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :surname, :email, :password, :password_confirmation) }
        devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :surname, :email, :password, :current_password) }
    end

    def splash_screen_controller?
        controller_name == 'splash_screen'
    end

    # def after_sign_out_path_for(resource_or_scope)
    #     unauthenticated_root_path
    # end
end
