defmodule Advent do
  @moduledoc false

  @doc """
  Return count of trees encountered.
  """
  @spec eval({Map.t(), integer(), integer()}) :: integer()
  def eval({map, width, height} \\ Advent.Input.parse()) do
    toboggan({map, width, height}, {0, 0, 0})
  end

  def toboggan({_, _, h}, {_, y, c}) when (h - 1) == y, do: c
  def toboggan({m, w, h}, {x, y, c}) do
    x = x + 3
    x = if x >= w, do: x - w, else: x

    y = y + 1

    c = if m[{x, y}] == "#", do: c + 1, else: c

    toboggan({m, w, h}, {x, y, c})
  end
end
