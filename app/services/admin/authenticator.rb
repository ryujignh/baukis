class Admin::Authenticator

  def initialize(administrator)
    @administrator = administrator
  end

  def authenticate(raw_password)
    # adminがnilじゃなくて
    # パスワードが設定されていて
    # 渡されたパスワードが正しければtrueを返す
    @administrator &&
      @administrator.hashed_password &&
      BCrypt::Password.new(@administrator.hashed_password) == raw_password
  end
end