#####################################################################
# t.string   | "email",             |                 | null: false
# t.string   | "email_for_index",   |                 | null: false
# t.string   | "family_name",       |                 | null: false
# t.string   | "given_name",        |                 | null: false
# t.string   | "family_name_kana",  |                 | null: false
# t.string   | "given_name_kana"    |                 |
# t.string   | "hashed_password"    |                 |
# t.date     | "start_date",        |                 | null: false
# t.date     | "end_date"           |                 |
# t.boolean  | "suspended",         | default: false, | null: false
#####################################################################

class StaffMember < ActiveRecord::Base
  has_many :events, class_name: 'StaffEvent', dependent: :destroy

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
    # Not suspend AND Start date is prior to today AND
    # end_date is nil OR end_date is more than Today
    !suspended? && start_date <= Date.today &&
      (end_date.nil? || end_date > Date.today)
  end

end
