StaffMember.create!(
	email: 'taro@example.com',
	family_name: '山田',
	given_name: '太郎',
	family_name_kana: 'ヤマダ',
	given_name_kana: 'タロウ',
	password: 'password',
	start_date: Date.today,
	)

family_names = %w{
  すみす:スミス:Smith
  佐藤:サトウ:Satoh
  伊藤:イトウ:Itoh
  我那覇:ガナハ:Ganaha
}

given_names = %w{
  太郎:タロウ:Taroh
  次郎:ジロウ:Jiroh
  三郎:サブロウ:Sabroh
  敦子:アツコ:Atsuko
  京子:キョウコ:Kyoko
}

20.times do |n|
  # n % 4してあげないと、4回目のループでfamily_nameがnilになる
  fn = family_names[n % 4].split(':')
  gn = given_names[n % 5].split(':')

  StaffMember.create!(
    email: "#{fn[2]}.#{gn[2]}@example.com",
    family_name: fn[0],
    given_name: gn[0],
    family_name_kana: fn[1],
    given_name_kana: gn[1],
    password: 'password',
    start_date: (100 - n).days.ago.to_date,
    end_date: n == 0 ? Date.today : nil,
    suspended: n == 1
    )
end