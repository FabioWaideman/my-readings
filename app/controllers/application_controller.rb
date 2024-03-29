class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  include Pundit::Authorization

  after_action :verify_authorized, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from Pundit::PolicyScopingNotPerformedError, with: :unpermitted_policy

  rescue_from ActionController::Redirecting::UnsafeRedirectError do
    redirect_to user_path(current_user), allow_other_host: true
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :full_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :full_name, :avatar, :about])
  end

  def unpermitted_policy
    flash[:notice] = "Please, create o policy for this route!"
  end

  def user_not_authorized
    flash[:alert] = "You're NOT authorized to perform this action!"
    redirect_to root_path
  end

  def skip_pundit?
    devise_controller? ||
    params[:controller] =~ /(^(rails_)?admin)|(^pages$)|(users)/
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end
end
