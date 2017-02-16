class Staff::Base < ApplicationController
  before_action :authorize

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

end