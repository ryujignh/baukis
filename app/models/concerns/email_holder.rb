module EmailHolder
  extend ActiveSupport::Concern

  included do
    include StringNormalizer

    # 大文字を小文字で統一する
    before_validation do
      self.email            = normalize_as_email(email)
      self.email_for_index  = email.downcase if email
    end

    # alow_blankで空入力の歳のエラーメッセージを重複しないようにする、presence: trueの
    # エラーメッセージを優先してあげる。
    validates :email, presence: true, email: { allow_blank: true }
    validates :email_for_index, uniqueness: { allow_blank: true }

    # もしValidationに失敗したら、フォームの下に赤くエラーメッセージを出してあげる。
    after_validation do
      if errors.include?(:email_for_index)
        errors.add(:email, :taken)
        errors.delete(:email_for_index)
      end
    end

  end
end