class StaffMemberPresenter < ModelPresenter
  delegate :suspended?, to: :object

  # Toggle On/Off of staff members suspend status
  # view contextとはERB自体（ちょっとまだわかってない）
  def suspended_mark
    suspended? ? raw('&#x2611;') : raw('&#x2610;')
  end
end