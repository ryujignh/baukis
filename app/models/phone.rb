# +------------------+--------------+------+-----+---------+----------------+
# | Field            | Type         | Null | Key | Default | Extra          |
# +------------------+--------------+------+-----+---------+----------------+
# | id               | int(11)      | NO   | PRI | NULL    | auto_increment |
# | customer_id      | int(11)      | NO   | MUL | NULL    |                |
# | address_id       | int(11)      | YES  | MUL | NULL    |                |
# | number           | varchar(255) | NO   |     | NULL    |                |
# | number_for_index | varchar(255) | NO   | MUL | NULL    |                |
# | primary          | tinyint(1)   | NO   |     | 0       |                |
# | created_at       | datetime     | YES  |     | NULL    |                |
# | updated_at       | datetime     | YES  |     | NULL    |                |
# | last_four_digits | varchar(255) | YES  | MUL | NULL    |                |
# +------------------+--------------+------+-----+---------+----------------+

class Phone < ActiveRecord::Base
  include StringNormalizer

  belongs_to :customer
  belongs_to :address

  before_validation do
    self.number = normalize_as_phone_number(number)
    self.number_for_index = number.gsub(/\D/, '') if number
  end

  before_create do
    self.customer = address.customer if address
    if number_for_index && number_for_index.size >= 4
      self.last_four_digits = number_for_index[-4, 4]
    end
  end

  validates :number, presence: true,
    # 0か1以上の+があって、1かそれ以上の数字があって、-サインの後に数字があって、
    # その組み合わせが0かそれ以上ある。
    format: { with: /\A\+?\d+(-\d+)*\z/, allow_blank: true }
end
