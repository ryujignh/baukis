city_names = %w(青巻市 赤巻市 黄巻市)

family_names = %w{
  佐藤:サトウ:satoh
  鈴木:スズキ:suzuki
  高橋:タカハシ:takahashi
  田中:タナカ:tanaka
  渡辺:ワタナベ:watanabe
  伊藤:イトウ:itoh
  山本:ヤマモト:yamamoto
  仲村:ナカムラ:nakamura
  小林:コバヤシ:kobayashi
  加藤:カトウ:katoh
}

given_names = %w{
  太郎:タロウ:Taroh
  次郎:ジロウ:Jiroh
  三郎:サブロウ:Sabroh
  敦子:アツコ:Atsuko
  京子:キョウコ:Kyoko
  静子:シズコ:Shizuko
  ひろ子:ヒロコ:Hiroko
  光子:ミツコ:Mitsuko
  りんこ:リンコ:Rinko
  ゆうか:ユウカ:Yuka
}

company_names = %w(OIAX ABC XYZ)

10.times do |n|
  10.times do |m|
    fn = family_names[n].split(':')
    gn = given_names[m].split(':')

    c = Customer.create!(
      email: "#{fn[2]}.#{gn[2]}@example.com"  ,
      family_name: fn[0],
      given_name: gn[0],
      family_name_kana: fn[1],
      given_name_kana: gn[1],
      password: 'customer',
      birthday: 60.years.ago.advance(seconds: rand(40.years)).to_date,
      gender: m < 5 ? 'male' : 'female',
    )

    if m % 2 == 0
      c.personal_phones.create!(number: sprintf('090-0000-%04d', n * 10 + m))
    end
    c.create_home_address!(
      postal_code: sprintf('%07d', rand(1_000_000)),
      prefecture: Address::PREFECTURE_NAMES.sample,
      city: city_names.sample,
      address1: '開発1-2-3',
      address2: 'レイツハイツ301号室',
    )
    if m % 10 == 0
      c.home_address.phones.create!(number: sprintf('03-0000-%04d', n))
    end
    if m % 3 == 0
      c.create_work_address!(
        postal_code: sprintf('%07d', rand(1_000_000)),
        prefecture: Address::PREFECTURE_NAMES.sample,
        city: city_names.sample,
        address1: '試験4-5-6',
        address2: 'レイツ2F',
        company_name: company_names.sample,
        )
    end
  end
end