defmodule Advent do
  def eval(map \\ Advent.Input.parse()) do
    lowest_points(map)
    |> Enum.map(&basin_size(&1, map))
    |> Enum.sort(fn a, b -> a > b end)
    |> then(fn [a, b, c | _rest] -> a * b * c end)
  end

  def surroundings({x, y}) do
    [
      {x + 1, y},
      {x - 1, y},
      {x, y + 1},
      {x, y - 1}
    ]
  end

  def basin_size(point, map), do: basin(point, map) |> MapSet.size()

  def basin(point, map, set \\ MapSet.new()) do
    set = MapSet.put(set, point)

    point
    |> surrounding_basin(map)
    |> MapSet.difference(set)
    |> MapSet.to_list()
    |> case do
      [] -> set
      sb -> Enum.reduce(sb, set, fn p, set -> basin(p, map, set) end)
    end
  end

  def surrounding_basin(point, map) do
    point
    |> surroundings()
    |> Enum.filter(fn p ->
      case map[p] do
        nil -> false
        "." -> false
        9 -> false
        _ -> true
      end
    end)
    |> MapSet.new()
  end

  def lowest_points(map) do
    Enum.filter(Map.keys(map), &surroundings_higher?(&1, map))
  end

  defp surroundings_higher?(point, map) do
    mp = map[point]

    point
    |> Advent.surroundings()
    |> Enum.all?(&higher?(map[&1], mp))
  end

  defp higher?(a, _) when is_nil(a), do: true
  defp higher?(a, b), do: a > b
end
