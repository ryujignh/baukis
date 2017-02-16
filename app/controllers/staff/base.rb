class Staff::Base < ApplicationController
  before_action :authorize
  before_action :check_account
  before_action :check_timeout

	private
	def current_staff_member
		if session[:staff_member_id]
      # 変数にStaffMemberのオブジェクトを代入する
			@current_staff_member ||=
				StaffMember.find_by(id: session[:staff_member_id])
		end
	end

	helper_method :current_staff_member

  def authorize
    unless current_staff_member
      flash.notice = '職員としてログインしてください。'
      redirect_to :staff_login
    end
  end

  def check_account
    # if staff member logged in && staff member is suspended?
    if current_staff_member && !current_staff_member.active?
      session.delete(:staff_member_id)
      flash.notice = 'アカウントが無効になりました'
      redirect_to :staff_root
    end

  end

  TIMEOUT = 60.minutes

  def check_timeout
    if current_staff_member
      # if last access time is greater than
      if session[:last_access_time] >= TIMEOUT.ago
        session[:last_access_time] = Time.current
      else
        session.delete(:staff_member_id)
        flash.alert = 'セッションがタイムアウトしました。'
        redirect_to :staff_login
      end
    end
  end

end