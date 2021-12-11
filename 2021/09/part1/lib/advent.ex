defmodule Advent do
  def eval({map, mx, my} \\ Advent.Input.parse()) do
    for(x <- 0..mx, y <- 0..my, do: {x, y})
    |> Enum.reduce(0, fn c, n ->
      surroundings(c)
      |> all_higher?(map, c)
      |> case do
        true -> n + map[c] + 1
        false -> n
      end
    end)
  end

  def all_higher?(ss, map, c) do
    Enum.all?(ss, fn p ->
      case map[p] do
        nil -> true # walls
        v -> v > map[c]
      end
    end)
  end

  def surroundings({x, y}) do
    [
      {x + 1, y},
      {x - 1, y},
      {x, y + 1},
      {x, y - 1}
    ]
  end
end
