FactoryGirl.define do
  factory :staff_member do
    sequence(:email) { |n| "member#{n}@example.com" }
    family_name 'Yamada'
    given_name 'Taroh'
    family_name_kana 'ヤマダ'
    given_name_kana 'タロウ'
    password 'pw'
    start_date { Date.yesterday }
    end_date nil
    suspended false
  end
end