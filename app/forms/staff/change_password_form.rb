class Staff::ChangePasswordForm
  # DBにモデルが紐付いていなくてもcall_backやvalidates等のavtive modelが持つ機能を
  # 使う場合に入れる。
  include ActiveModel::Model

  attr_accessor :object, :current_password, :new_password,
    :new_password_confirmation
  # confirmation: trueで_confirmationが付いたフィールドと比較して、
  # 値が一致しなければValidation errorを返す。
  validates :new_password, presence: true, confirmation: true

  validate do
    unless Staff::Authenticator.new(object).authenticate(current_password)
      errors.add(:current_password, :wrong)
    end
  end

  def save
    if valid?
      object.password = new_password
      object.save!
    end
  end

end