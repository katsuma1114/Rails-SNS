class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?

    def after_sign_in_path_for(resource)
      root_path
    end

    def current_user
      ActiveDecorator::Decorator.instance.decorate(super) if super.present?
      super
    end

    protected
  
    def configure_permitted_parameters
      added_attrs = [ :email, :user_name, :password, :password_confirmation ]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
      devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    end
end
