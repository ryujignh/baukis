# +-----------------+--------------+------+-----+---------+----------------+
# | Field           | Type         | Null | Key | Default | Extra          |
# +-----------------+--------------+------+-----+---------+----------------+
# | id              | int(11)      | NO   | PRI | NULL    | auto_increment |
# | email           | varchar(255) | NO   |     | NULL    |                |
# | email_for_index | varchar(255) | NO   | UNI | NULL    |                |
# | hashed_password | varchar(255) | YES  |     | NULL    |                |
# | suspended       | tinyint(1)   | NO   |     | 0       |                |
# | created_at      | datetime     | YES  |     | NULL    |                |
# | updated_at      | datetime     | YES  |     | NULL    |                |
# +-----------------+--------------+------+-----+---------+----------------+

class Administrator < ActiveRecord::Base
  include EmailHolder
  include PasswordHolder

  def active?
    !suspended?
  end

end
