module SessionsHelper
  def sign_in(user)
    # remember_token = User.new_remember_token
    #cookies.permanent[:remember_token] = remember_token
    #user.update_attribute(:RememberToken, User.encrypt(remember_token))

    user.update_attribute(:RememberToken, User.encrypt(User.new_remember_token)) if user.RememberToken.blank?
    cookies.permanent[:remember_token] = user.RememberToken
    self.current_user = user

    # change by lzh
    session[:tel_param] = current_user.Phone
    # change by lzh

  end

  def sign_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    #remember_token = User.encrypt(cookies[:remember_token])
    remember_token = cookies[:remember_token] || params[:auth_token]
    @current_user ||= User.find_by(RememberToken: remember_token) if remember_token
  end

  def current_user?(user)
    user == current_user
  end

  def sign_out
    #current_user.update_attribute(:RememberToken, User.encrypt(User.new_remember_token))
    self.current_user = nil
    cookies.delete(:remember_token)
  end
end
