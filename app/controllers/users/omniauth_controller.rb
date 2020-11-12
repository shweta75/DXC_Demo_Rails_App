# frozen_string_literal: true

class Devise::OmniauthCallbacksController < DeviseController
    prepend_before_action { request.env["devise.skip_timeout"] = true }

    skip_before_action :verify_authenticity_token
  
    def sign_in_with(provider_name)
      @user = User.from_omniauth(request.env["omniauth.auth"])
      byebug
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => provider_name) if is_navigational_format?
    end
  
    def facebook
      sign_in_with "Facebook"
    end
  
    def linkedin
      sign_in_with "LinkedIn"
    end
  
    def twitter
      sign_in_with "Twitter"
    end
  
    def google_oauth2
      sign_in_with "Google"
    end
  
    def developer
      sign_in_with "Developer"
    end
    
    def passthru
      render status: 404, plain: "Not found. Authentication passthru."
    end
  
    def failure
      set_flash_message! :alert, :failure, kind: OmniAuth::Utils.camelize(failed_strategy.name), reason: failure_message
      redirect_to after_omniauth_failure_path_for(resource_name)
    end
  
    protected
  
    def failed_strategy
      request.respond_to?(:get_header) ? request.get_header("omniauth.error.strategy") : request.env["omniauth.error.strategy"]
    end
  
    def failure_message
      exception = request.respond_to?(:get_header) ? request.get_header("omniauth.error") : request.env["omniauth.error"]
      error   = exception.error_reason if exception.respond_to?(:error_reason)
      error ||= exception.error        if exception.respond_to?(:error)
      error ||= (request.respond_to?(:get_header) ? request.get_header("omniauth.error.type") : request.env["omniauth.error.type"]).to_s
      error.to_s.humanize if error
    end
  
    def after_omniauth_failure_path_for(scope)
      new_session_path(scope)
    end
  
    def translation_scope
      'devise.omniauth_callbacks'
    end
  end
  
# class Users::OmniauthController < Devise::OmniauthCallbacksController

# end
