#####################################################################
# String  | "email",          |                 | null: false
# String  | "email_for_index",|                 | null: false
# String  | "hashed_password" |                 |
# Boolean | "suspended",      | default: false, | null: false
#####################################################################

class Administrator < ActiveRecord::Base
  include EmailHolder
  include PasswordHolder

  def active?
    !suspended?
  end

end
