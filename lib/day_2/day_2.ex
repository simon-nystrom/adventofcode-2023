defmodule Day2.Day2 do
  @num_red 12
  @num_green 13
  @num_blue 14

  def allowed?(amount) do
    {quantity, color} = Integer.parse(amount)

    case color do
      " red" -> quantity <= @num_red
      " green" -> quantity <= @num_green
      " blue" -> quantity <= @num_blue
    end
  end

  def solve1() do
    File.read!("./lib/day_2/day_2.txt")
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line -> Regex.scan(~r/(\d+ (?:red|green|blue))/, line) end)
    |> Enum.map(fn matches -> Enum.map(matches, fn match -> List.first(match) end) end)
    |> Enum.map(fn amounts -> Enum.map(amounts, fn amount -> allowed?(amount) end) end)
    |> Enum.with_index(fn states, index -> {index + 1, Enum.all?(states)} end)
    |> Enum.filter(fn {_, is_allowed} -> is_allowed end)
    |> Enum.map(fn {index, _} -> index end)
    |> Enum.sum()
    |> dbg
  end

  def solve2() do
    File.read!("./lib/day_2/day_2.txt")
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line -> Regex.scan(~r/(\d+ (?:red|green|blue))/, line) end)
    |> Enum.map(fn matches -> Enum.map(matches, fn match -> List.first(match) end) end)
    |> Enum.map(fn amounts -> Enum.map(amounts, &Integer.parse/1) end)
    |> Enum.map(fn parsed ->
      Enum.group_by(
        parsed,
        fn {_, color} -> color end,
        fn {amount, _} -> amount end
      )
    end)
    |> Enum.map(fn grouped -> Enum.map(grouped, fn {_, v} -> Enum.max(v) end) end)
    |> Enum.map(&Enum.product/1)
    |> Enum.sum()
  end
end
