defmodule Advent do
  @moduledoc false

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> visible_trees()
  end

  def visible_trees(map) do
    {{max_x, _}, _} = Enum.max_by(map, fn {{x, _y}, _v} -> x end)
    {{_, max_y}, _} = Enum.max_by(map, fn {{_x, y}, _v} -> y end)

    rt = ring_trees(max_x, max_y)
    vit = visible_interior_trees(map, max_x, max_y)

    rt + vit
  end

  defp ring_trees(max_x, max_y), do: 2 * max_x + 2 * max_y

  defp visible_interior_trees(map, max_x, max_y) do
    Enum.reduce(1..(max_y - 1), 0, fn y, c ->
      Enum.reduce(1..(max_x - 1), c, fn x, c ->
        if visible?({map, max_x, max_y}, x, y), do: c + 1, else: c
      end)
    end)
  end

  defp visible?({map, _max_x, _max_y} = ms, x, y) do
    tree = Map.get(map, {x, y})

    all_shorter?(tree, above(ms, x, y)) or
      all_shorter?(tree, below(ms, x, y)) or
      all_shorter?(tree, left(ms, x, y)) or
      all_shorter?(tree, right(ms, x, y))
  end

  defp all_shorter?(tree, others), do: Enum.all?(others, &(&1 < tree))

  defp above({map, _max_x, _max_y}, px, py),
    do: for(y <- (py - 1)..0, do: Map.get(map, {px, y}))

  defp below({map, _max_x, max_y}, px, py),
    do: for(y <- (py + 1)..max_y, do: Map.get(map, {px, y}))

  defp left({map, _max_x, _max_y}, px, py),
    do: for(x <- (px - 1)..0, do: Map.get(map, {x, py}))

  defp right({map, max_x, _max_y}, px, py),
    do: for(x <- (px + 1)..max_x, do: Map.get(map, {x, py}))
end
