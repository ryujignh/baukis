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

end
