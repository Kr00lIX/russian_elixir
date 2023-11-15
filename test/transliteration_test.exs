defmodule RussianTest.Transliteration do
  use Russian.TestCase
  doctest Russian.Transliteration

  def t(text) do
    Russian.transliterate(text)
  end

  test "should transliterate properly" do
    assert t("Это просто некий текст") == "Eto prosto nekiy tekst"
    assert t("щ") == "sch"
    assert t("стансы") == "stansy"
    assert t("упущение") == "upuschenie"
    assert t("ш") == "sh"
    assert t("Ш") == "SH"
    assert t("ц") == "ts"
  end

  test "should properly transliterate mixed russian-english strings" do
    assert t(
             "Это кусок строки русских букв v peremeshku s latinizey i амперсандом (pozor!) & something"
           ) ==
             "Eto kusok stroki russkih bukv v peremeshku s latinizey i ampersandom (pozor!) & something"
  end

  test "should properly transliterate mixed case chars in a string" do
    assert t("НЕВЕРОЯТНОЕ УПУЩЕНИЕ") == "NEVEROYATNOE UPUSCHENIE"
    assert t("Невероятное Упущение") == "Neveroyatnoe Upuschenie"
    assert t("Шерстяной Заяц") == "Sherstyanoy Zayats"
    assert t("Н.П. Шерстяков") == "N.P. Sherstyakov"
    assert t("ШАРОВАРЫ") == "SHAROVARY"
  end

  test "should work for multi-char substrings" do
    assert t("38 воробьёв") == "38 vorobiev"
    assert t("Вася Воробьёв") == "Vasya Vorobiev"
    assert t("Алябьев") == "Alyabiev"
    assert t("АЛЯБЬЕВ") == "ALYABIEV"
  end
end
