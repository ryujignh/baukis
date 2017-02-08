class Staff::Authenticator

  def initialize(staff_member)
    @staff_member = staff_member
  end

  def authenticate(raw_password)
    # staff_memberがnilじゃなくて
    # 有効で
    # パスワードが設定されていて
    # 開始日が今日以前、
    # なお終了日が設定されていあくて
    # 渡されたパスワードが正しければtrueを返す
    @staff_member &&
      @staff_member.hashed_password &&
      @staff_member.start_date <= Date.today &&
      (@staff_member.end_date.nil? || @staff_member.end_date > Date.today) &&
      BCrypt::Password.new(@staff_member.hashed_password) == raw_password
  end
end