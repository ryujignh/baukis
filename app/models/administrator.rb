#####################################################################
# String  | "email",          |                 | null: false
# String  | "email_for_index",|                 | null: false
# String  | "hashed_password" |                 |
# Boolean | "suspended",      | default: false, | null: false
#####################################################################

class Administrator < ActiveRecord::Base

  before_validation do
    self.email_for_index = email.downcase if email
  end

  def password=(raw_password)
    if raw_password.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.hashed_password = nil
    end
  end

  def active?
    !suspended?
  end

end
