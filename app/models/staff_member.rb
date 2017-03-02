#####################################################################
# String   | "email",             |                 | null: false
# String   | "email_for_index",   |                 | null: false
# String   | "family_name",       |                 | null: false
# String   | "given_name",        |                 | null: false
# String   | "family_name_kana",  |                 | null: false
# String   | "given_name_kana"    |                 |
# String   | "hashed_password"    |                 |
# Date     | "start_date",        |                 | null: false
# Date     | "end_date"           |                 |
# Boolean  | "suspended",         | default: false, | null: false
#####################################################################

class StaffMember < ActiveRecord::Base
  include EmailHolder
  include PasswordHolder
  include PersonalNameHolder

  has_many :events, class_name: 'StaffEvent', dependent: :destroy

  # 開始日は2000/1/1以降、かつ今日から１年以内
  validates :start_date, presence: true, date: {
    after_or_equal_to: Date.new(2000, 1, 1),
    before: -> (obj) { 1.year.from_now.to_date },
    allow_blank: true
  }
  # 終了日は開始日よりも後で、今日から一年以内、空でもOK
  validates :end_date, date: {
    after: :start_date,
    before: -> (obj) { 1.year.from_now.to_date },
    allow_blank: true
  }

  def active?
    # Not suspend AND Start date is prior to today AND
    # end_date is nil OR end_date is more than Today
    !suspended? && start_date <= Date.today &&
      (end_date.nil? || end_date > Date.today)
  end
end
