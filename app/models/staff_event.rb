# +-----------------+--------------+------+-----+---------+----------------+
# | Field           | Type         | Null | Key | Default | Extra          |
# +-----------------+--------------+------+-----+---------+----------------+
# | id              | int(11)      | NO   | PRI | NULL    | auto_increment |
# | staff_member_id | int(11)      | NO   | MUL | NULL    |                |
# | type            | varchar(255) | NO   |     | NULL    |                |
# | created_at      | datetime     | NO   | MUL | NULL    |                |
# +-----------------+--------------+------+-----+---------+----------------+

class StaffEvent < ActiveRecord::Base
  self.inheritance_column = nil

  belongs_to :member, class_name: 'StaffMember', foreign_key: 'staff_member_id'
  alias_attribute :occurred_at, :created_at

  DESCRIPTION = {
    logged_in: 'ログイン',
    logged_out: 'ログアウト',
    rejected: 'ログイン拒否'
  }

  def description
    DESCRIPTION[type.to_sym]
  end
end
