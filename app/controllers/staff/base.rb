class Staff::Base < ApplicationController
  before_action :authorize
  before_action :check_account

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

end