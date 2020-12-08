defmodule Advent do
  @moduledoc false

  @doc """
  Return product of trees encountered at different slopes.
  """
  @spec eval({Map.t(), integer(), integer()}) :: integer()
  def eval({map, width, height} \\ Advent.Input.parse()) do
    slopes()
    |> Enum.map(fn slope ->
      toboggan({map, width, height}, {0, 0, 0}, slope)
    end)
    |> Enum.reduce(1, fn x, p -> x * p end)
  end

  def toboggan({_, _, h}, {_, y, c}, _) when y >= (h - 1), do: c
  def toboggan({m, w, h}, {x, y, c}, slope) do
    {x, y} = slide({x, y}, w, slope)

    c = if m[{x, y}] == "#", do: c + 1, else: c

    toboggan({m, w, h}, {x, y, c}, slope)
  end

  def slide({x, y}, w, {sx, sy} \\ {3, 1}) do
    x = x + sx
    x = if x >= w, do: x - w, else: x

    y = y + sy
    
    {x, y}
  end

  def slopes() do
    [
      {1, 1},
      {3, 1},
      {5, 1},
      {7, 1},
      {1, 2}
    ]
  end
end
