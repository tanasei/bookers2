class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!,except: [:top, :about, :sign_up, :sign_in]

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  def is_my_userpage
    if current_user.id != params[:id].to_i
      redirect_to user_path(current_user.id)
    end
  end

  def is_my_bookpage
    if Book.find_by(id: params[:id].to_i).user_id != current_user.id
      redirect_to books_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
