japan = %w(東京 大阪  北海道 沖縄 京都 奈良 福岡 東北地方 関東地方 北陸・北信越地方 東海地方 近畿地方 中国地方 四国地方 九州地方)
asia = %w(韓国 中国 台湾 タイ インドネシア シンガポール ベトナム トルコ 中東)
oceania = %w(オーストラリア ニュージーランド)
north_america = %w(アメリカ ハワイ グアム カナダ)
europe = %w(フランス イタリア ドイツ イギリス スイス)
other = %w(アフリカ 中央アメリカ 南アメリカ カリブ海 南極)
big_categories = [japan, asia, oceania, north_america, europe, other]
jp_big_categories = %w(国内旅行 アジア オセアニア 北アメリカ ヨーロッパ その他)

big_categories.zip(jp_big_categories) do |big_category, jp_big_category|
  big_category.each do |name|
    Category.create(big_category: jp_big_category, name: name)
  end
end