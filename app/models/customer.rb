# +------------------+--------------+------+-----+---------+----------------+
# | Field            | Type         | Null | Key | Default | Extra          |
# +------------------+--------------+------+-----+---------+----------------+
# | id               | int(11)      | NO   | PRI | NULL    | auto_increment |
# | email            | varchar(255) | NO   |     | NULL    |                |
# | email_for_index  | varchar(255) | NO   | UNI | NULL    |                |
# | family_name      | varchar(255) | NO   |     | NULL    |                |
# | family_name_kana | varchar(255) | NO   | MUL | NULL    |                |
# | given_name       | varchar(255) | NO   |     | NULL    |                |
# | given_name_kana  | varchar(255) | NO   | MUL | NULL    |                |
# | gender           | varchar(255) | YES  |     | NULL    |                |
# | birthday         | date         | YES  |     | NULL    |                |
# | hashed_password  | varchar(255) | YES  |     | NULL    |                |
# | created_at       | datetime     | YES  |     | NULL    |                |
# | updated_at       | datetime     | YES  |     | NULL    |                |
# | birth_year       | int(11)      | YES  | MUL | NULL    |                |
# | birth_month      | int(11)      | YES  | MUL | NULL    |                |
# | birth_mday       | int(11)      | YES  | MUL | NULL    |                |
# +------------------+--------------+------+-----+---------+----------------+

class Customer < ActiveRecord::Base
  include EmailHolder
  include PasswordHolder
  include PersonalNameHolder
  # autosave: true or falseで親モデルが保存した時にhas...関連
  # 付けられているモデルを更新するか決められる。
  # 基本的に更新しないほうがいい（思いがけない処理をする場合があるので）
  has_one :home_address, dependent: :destroy, autosave: true
  has_one :work_address, dependent: :destroy, autosave: true

  # autosaveはAddressモデル側で行われるため、ここでは定義しない。
  has_many :phones, dependent: :destroy
  # personal_phonesというaliasを作るので、クラス名を指定してあげる必用がある。
  has_many :personal_phones, -> { where(address_id: nil).order(:id) },
    class_name: 'Phone', autosave: true

  validates :gender, inclusion: { in: %w(male female), allow_blank: true }
  validates :birthday, date: {
    after: Date.new(1900, 1, 1),
    before: -> (obj) { Date.today },
    allow_blank: true
  }

  before_save do
    if birthday
      self.birth_year = birthday.year
      self.birth_month = birthday.month
      self.birth_mday = birthday.mday
    end
  end

end
