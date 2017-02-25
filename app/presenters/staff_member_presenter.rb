class StaffMemberPresenter < ModelPresenter
  delegate :suspended?, to: :object

  # Toggle On/Off of staff members suspend status
  # view contextとはERB自体（ちょっとまだわかってない）
  def suspended_mark
    suspended? ? raw('&#x2611;') : raw('&#x2610;')
  end

  def full_name
    "#{object.family_name} #{object.given_name}"
  end

  def full_name_kana
    "#{object.family_name_kana} #{object.given_name_kana}"
  end

end