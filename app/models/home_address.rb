class HomeAddress < Address
  validates :postal_code, :prefecture, :city, :address1, :address2, presence: true
  validates :company_name, :division_name, absence: true
end