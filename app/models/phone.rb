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
  end

  validates :number, presence: true,
    # 0か1以上の+があって、1かそれ以上の数字があって、-サインの後に数字があって、
    # その組み合わせが0かそれ以上ある。
    format: { with: /\A\+?\d+(-\d+)*\z/, allow_blank: true }
end