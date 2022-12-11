defmodule Advent do
  @moduledoc false

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> max_scenic_score()
  end

  def max_scenic_score(map) do
    {{max_x, _}, _} = Enum.max_by(map, fn {{x, _y}, _v} -> x end)
    {{_, max_y}, _} = Enum.max_by(map, fn {{_x, y}, _v} -> y end)

    map
    |> score_interior_trees(max_x, max_y)
    |> Enum.max()
  end

  defp score_interior_trees(map, max_x, max_y) do
    Enum.reduce(1..(max_y - 1), [], fn y, s ->
      Enum.reduce(1..(max_x - 1), s, fn x, s ->
        [score({map, max_x, max_y}, x, y) | s]
      end)
    end)
  end

  defp score({map, _max_x, _max_y} = ms, x, y) do
    tree = Map.get(map, {x, y})

    visibility(tree, above(ms, x, y)) *
      visibility(tree, below(ms, x, y)) *
      visibility(tree, left(ms, x, y)) *
      visibility(tree, right(ms, x, y))
  end

  defp visibility(tree, others) do
    Enum.reduce_while(others, 0, fn o, v ->
      {if(o >= tree, do: :halt, else: :cont), v + 1}
    end)
  end

  defp above({map, _max_x, _max_y}, px, py),
    do: for(y <- (py - 1)..0, do: Map.get(map, {px, y}))

  defp below({map, _max_x, max_y}, px, py),
    do: for(y <- (py + 1)..max_y, do: Map.get(map, {px, y}))

  defp left({map, _max_x, _max_y}, px, py),
    do: for(x <- (px - 1)..0, do: Map.get(map, {x, py}))

  defp right({map, max_x, _max_y}, px, py),
    do: for(x <- (px + 1)..max_x, do: Map.get(map, {x, py}))
end
