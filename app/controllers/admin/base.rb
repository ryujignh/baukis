class Admin::Base < ApplicationController
  # Basically, almost every admin related actions require authorization,
  # so put the callback in the base class so other subclasses can inherite
  before_action :authorize

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

end