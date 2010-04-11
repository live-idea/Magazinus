# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user
  before_filter :current_category
  before_filter :current_good
  before_filter :set_host
  before_filter :goods_for_current_category

  def set_host
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end

  def current_category
      @category = Category.find_by_id(params[:category_id]) unless params[:category_id].nil?
  end

  def current_good
      @good = Good.find_by_id(params[:id]) unless params[:id].nil?
  end
  
  def goods_for_current_category
    unless (@category.nil?)
      @goods = Good.find_all_by_category_id(@category)
    else
      @goods = Good.find(:all, :conditions=>["category_id IS NULL"])
    end
  end

  private
    def current_user_session
        return @current_user_session if defined?(@current_user_session)
        @current_user_session = UserSession.find
    end

    def current_user
        return @current_user if defined?(@current_user)
        @current_user = current_user_session && current_user_session.user
    end


    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to account_url
        return false
      end
    end

    def store_location
      session[:return_to] = request.request_uri
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

end
