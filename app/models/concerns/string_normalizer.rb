require 'nkf'

module StringNormalizer
  extend ActiveSupport::Concern

  # Zen to han
  def normalize_as_name(text)
    NKF.nkf('-w -Z1', text).strip if text
  end

  # ひらがな、半角カナを全角カナに変換
  def normalize_as_furigana(text)
    NKF.nkf('-w -Z1 --katakana', text).strip if text
  end

  # 全角英数字を半角英数字に変換
  def normalize_as_email(text)
    NKF.nkf('-w -Z1', text).strip if text
  end

  # Zen to han, and remove '-'
  def normalize_as_postal_code(text)
    NKF.nkf('-w -Z1', text).strip.gsub(/-/, '') if text
  end
end
