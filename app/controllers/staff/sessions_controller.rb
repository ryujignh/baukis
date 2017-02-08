class Staff::SessionsController < Staff::Base
  def new
    if current_staff_member
      redirect_to :staff_root
    else
      @form = Staff::LoginForm.new
      render action: 'new'
    end
  end

  def create
    @form = Staff::LoginForm.new(params[:staff_login_form])
    if @form.email.present?
      staff_member = StaffMember.find_by(email_for_index: @form.email.downcase)
    end
    if Staff::Authenticator.new(staff_member).authenticate(@form.password) # もしauthenticateされれば
      if staff_member.suspended
        flash.notice = 'Your account looks like suspended'
        render action: 'new'
      else
        session[:staff_member_id] = staff_member.id
        flash.notice = 'You have been logged in'
        redirect_to :staff_root
      end
    else
      # このアクションでしかフラッシュを出さないなら、.nowをつけてあげる。
      flash.now.alert = 'Wrong email or password'
      render action: 'new'
    end
  end

  def destroy
    session.delete(:staff_member_id)
    flash.notice = 'You have been logged out'
    redirect_to :staff_root
  end

end
