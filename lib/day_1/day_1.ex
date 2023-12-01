defmodule Day1.Day1 do
  def solve1() do
    File.read!("./lib/day_1/day_1.txt")
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.replace(&1, ~r/[^1-9]/, ""))
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&String.to_integer(String.first(&1) <> String.last(&1)))
    |> Enum.sum()
  end

  def solve2() do
    File.read!("./lib/day_1/day_1.txt")
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn a ->
      [
        Regex.scan(~r/\d/, a, return: :index),
        Regex.scan(~r/one/, a, return: :index),
        Regex.scan(~r/two/, a, return: :index),
        Regex.scan(~r/three/, a, return: :index),
        Regex.scan(~r/four/, a, return: :index),
        Regex.scan(~r/five/, a, return: :index),
        Regex.scan(~r/six/, a, return: :index),
        Regex.scan(~r/seven/, a, return: :index),
        Regex.scan(~r/eight/, a, return: :index),
        Regex.scan(~r/nine/, a, return: :index)
      ]
      |> Enum.reject(fn x -> x == [] end)
      |> Enum.flat_map(fn x -> Enum.flat_map(x, &Function.identity/1) end)
      |> Enum.sort_by(&elem(&1, 0))
      |> match_to_value(a)
    end)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end

  defp match_to_value(match, str) do
    {p1, l1} = List.first(match)
    {p2, l2} = List.last(match)

    a = String.slice(str, p1, l1)
    b = String.slice(str, p2, l2)

    translate(a) <> translate(b)
  end

  defp translate(d) do
    case d do
      "one" -> "1"
      "two" -> "2"
      "three" -> "3"
      "four" -> "4"
      "five" -> "5"
      "six" -> "6"
      "seven" -> "7"
      "eight" -> "8"
      "nine" -> "9"
      _ -> d
    end
  end
end
