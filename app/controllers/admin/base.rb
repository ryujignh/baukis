class Admin::Base < ApplicationController
  # Basically, almost every admin related actions require authorization,
  # so put the callback in the base class so other subclasses can inherite
  before_action :authorize
  before_action :check_account
  before_action :check_timeout

	private

	def current_administrator
		if session[:administrator_id]
			@current_administrator ||=
				Administrator.find_by(id: session[:administrator_id])
		end
	end

	helper_method :current_administrator

  def authorize
    unless current_administrator
      flash.notice = '管理者としてログインしてください。'
      redirect_to :admin_login
    end
  end

  def check_account
    if current_administrator && !current_administrator.active?
      session.delete(:administrator_id)
      flash.notice = 'アカウントが無効になりました'
      redirect_to :admin_root
    end
  end

  TIMEOUT = 60.minutes

  def check_timeout
    if current_administrator
      # if last access time is greater than
      if session[:last_access_time] >= TIMEOUT.ago
        session[:last_access_time] = Time.current
      else
        session.delete(:administrator_id)
        flash.alert = 'セッションがタイムアウトしました。'
        redirect_to :admin_login
      end
    end
  end

end