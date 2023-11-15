defmodule Russian do
  @moduledoc """
    Russian transliteration

    Транслитерация для букв русского алфавита

    iex> Russian.transliterate("Строка на русском языке")
    "Stroka na russkom yazyke"

    Transliteration heavily based on rutils gem by Julian "julik" Tarkhanov and Co.
    <http://rutils.rubyforge.org/>
    Cleaned up and optimized.
  """

  defmacro __using__(_opts) do
    quote do
      import Russian
    end
  end

  @doc """
    Transliterate a string with russian characters
    Возвращает строку, в которой все буквы русского алфавита заменены на похожую по звучанию латиницу

    iex> Russian.transliterate "Строка на русском языке"
    "Stroka na russkom yazyke"
  """
  @spec transliterate(String.t()) :: String.t()
  def transliterate(text) do
    Russian.Transliteration.transliterate(text)
  end

  defmodule Transliteration do
    @moduledoc ~S"""
      Russian transliteration

      Транслитерация для букв русского алфавита

      Transliteration heavily based on rutils gem by Julian "julik" Tarkhanov and Co.
      <http://rutils.rubyforge.org/>
      Cleaned up and optimized.
    """

    @lower_single %{
      "і" => "i",
      "ґ" => "g",
      "ё" => "yo",
      "№" => "#",
      "є" => "e",
      "ї" => "yi",
      "а" => "a",
      "б" => "b",
      "в" => "v",
      "г" => "g",
      "д" => "d",
      "е" => "e",
      "ж" => "zh",
      "з" => "z",
      "и" => "i",
      "й" => "y",
      "к" => "k",
      "л" => "l",
      "м" => "m",
      "н" => "n",
      "о" => "o",
      "п" => "p",
      "р" => "r",
      "с" => "s",
      "т" => "t",
      "у" => "u",
      "ф" => "f",
      "х" => "h",
      "ц" => "ts",
      "ч" => "ch",
      "ш" => "sh",
      "щ" => "sch",
      "ъ" => "'",
      "ы" => "y",
      "ь" => "",
      "э" => "e",
      "ю" => "yu",
      "я" => "ya"
    }

    @lower_multi %{
      "ье" => "ie",
      "ьё" => "ie"
    }

    @uppper_single %{
      "Ґ" => "G",
      "Ё" => "YO",
      "Є" => "E",
      "Ї" => "YI",
      "І" => "I",
      "А" => "A",
      "Б" => "B",
      "В" => "V",
      "Г" => "G",
      "Д" => "D",
      "Е" => "E",
      "Ж" => "ZH",
      "З" => "Z",
      "И" => "I",
      "Й" => "Y",
      "К" => "K",
      "Л" => "L",
      "М" => "M",
      "Н" => "N",
      "О" => "O",
      "П" => "P",
      "Р" => "R",
      "С" => "S",
      "Т" => "T",
      "У" => "U",
      "Ф" => "F",
      "Х" => "H",
      "Ц" => "TS",
      "Ч" => "CH",
      "Ш" => "SH",
      "Щ" => "SCH",
      "Ъ" => "'",
      "Ы" => "Y",
      "Ь" => "",
      "Э" => "E",
      "Ю" => "YU",
      "Я" => "YA"
    }

    @upper_multi %{
      "ЬЕ" => "IE",
      "ЬЁ" => "IE"
    }

    @lower Map.merge(@lower_single, @lower_multi)
    @upper Map.merge(@uppper_single, @upper_multi)

    multi_keys_reg = Map.merge(@lower_multi, @upper_multi) |> Map.keys() |> Enum.join("|")
    @chars_regex ~r/(#{multi_keys_reg}|\w|.)/um

    @doc """
    Transliterate a string with russian characters

    Возвращает строку, в которой все буквы русского алфавита заменены на похожую по звучанию латиницу
    """
    @spec transliterate(String.t()) :: String.t()
    def transliterate(str) do
      trans_chars(Regex.scan(@chars_regex, str, capture: :first))
    end

    defp trans_chars([[nil]]) do
      ""
    end

    defp trans_chars([[char]]) do
      trans_chars([[char], [nil]])
    end

    defp trans_chars([[char], [nchar] | tail]) do
      result =
        cond do
          Map.has_key?(@upper, char) && Map.has_key?(@lower, nchar) ->
            @upper[char] |> String.downcase() |> String.capitalize()

          Map.has_key?(@upper, char) ->
            @upper[char]

          Map.has_key?(@lower, char) ->
            @lower[char]

          true ->
            char
        end

      result <> trans_chars([[nchar] | tail])
    end
  end
end
