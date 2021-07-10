class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :login_required

  private
  def login_required
    redirect_to new_session_path unless current_user
  end

  def authenticate_user
    if logged_in?
      unless current_user.id == @picture.user_id
        flash[:notice] = "Nooooo!"
        redirect_to pictures_path
      end
    else
      redirect_to new_user_path, notice:"LoginPlease"
    end
  end
  def ensure_current_user
    if logged_in?
      unless current_user.id == params[:id].to_i
        flash[:notice] = "Nooooo!"
        redirect_to pictures_path
      end
    else
      redirect_to new_user_path, notice:"LoginPlease"
    end
  end

end
