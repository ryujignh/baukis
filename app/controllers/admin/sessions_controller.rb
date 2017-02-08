class Admin::SessionsController < Admin::Base
  def new
    if current_administrator
      redirect_to :admin_root
    else
      @form = Admin::LoginForm.new
      render action: 'new'
    end
  end

  def create
    @form = Admin::LoginForm.new(params[:admin_login_form])
    if @form.email.present?
      administrator = Administrator.find_by(email_for_index: @form.email.downcase)
    end
    # アドミンがいて、さらに認証されていれば
    if Admin::Authenticator.new(administrator).authenticate(@form.password)
      # もしサスペンドされていたらログイン画面に戻す
      if administrator.suspended?
        flash.now.alert = 'Your account has been suspended'
        render action: 'new'
      # サスペンドされていなければ、ログインしてルート画面に移動する
      else
        session[:administrator_id] = administrator.id
        flash.notice = 'You have been logged in'
        redirect_to :admin_root
      end
    # アドミンがいなければ、ログイン画面を再表示する
    else
      flash.now.alert = 'Invalid email or password'
      render action: 'new'
    end

  end

  def destroy
    session.delete(:administrator_id)
    flash.notice = 'You have been logged out'
    redirect_to :admin_root
  end

end
