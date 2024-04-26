module Authentication
  extend ActiveSupport::Concern
  
  included do

    private
  
    def current_admin
      @current_admin ||= Admin.find_by(id: session[:admin_id]) if session[:admin_id].present?
    end
  
    def admin_signed_in?
      current_admin.present?
    end

    def sign_in(admin)
      session[:admin_id] = admin.id
    end

    def sing_out
      session.delete(:admin_id)
    end

    def require_no_authentication
      return unless admin_signed_in?

      flash[:warning] = 'You are alread sign in!'
      redirect_to root_path
    end

    def require_authentication
      return if admin_signed_in?

      flash[:warning] = 'You are not sign in!'
      redirect_to root_path
    end
  
    helper_method :current_admin, :admin_signed_in?
  end
end