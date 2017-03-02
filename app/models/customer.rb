class Customer < ActiveRecord::Base
  include EmailHolder
  include PersonalNameHolder
  # autosave: true or falseで親モデルが保存した時にhas...関連
  # 付けられているモデルを更新するか決められる。
  # 基本的に更新しないほうがいい（思いがけない処理をする場合があるので）
  has_one :home_address, dependent: :destroy, autosave: true
  has_one :work_address, dependent: :destroy, autosave: true

  validates :gender, inclusion: { in: %w(male female), allow_blank: true }
  validates :birthday, date: {
    after: Date.new(1900, 1, 1),
    before: -> (obj) { Date.today },
    allow_blank: true
  }

  def password=(raw_password)
    if raw_password.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.hashed_password = nil
    end
  end
end
