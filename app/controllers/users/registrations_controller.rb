class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :configure_sign_up_params, only: [:create]
  before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
     super
   end

  # POST /resource
  def create

    if params["user"]["user_id"].blank? or params["user"]["user_id"].nil?   
      flash[:error] = "Must have a Student ID/Employee ID!"
      redirect_to new_user_registration_path
      return
    elsif User.all.map(&:user_id).include? params["user"]["user_id"].to_i
       flash[:error] = "An account with this Student ID/Employee ID already exists!"
      redirect_to new_user_session_path
      return
    end
    super
    @user.add_role params["user"]["role"].split.last
  end

  # GET /resource/edit
   def edit
     super
   end

  #PUT /resource
   def update
     super
   end

  # DELETE /resource
   def destroy
     super
   end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # You can put the params you want to permit in the empty array.
  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name, :user_id]
  end

  # You can put the params you want to permit in the empty array.
  def configure_account_update_params
     devise_parameter_sanitizer.for(:account_update) << [:first_name, :last_name, :user_id]
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
