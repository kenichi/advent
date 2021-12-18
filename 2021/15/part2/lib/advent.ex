defmodule Advent do
  @times 5

  def eval(map \\ Advent.Input.parse()) do
    map
    |> multiply_map()
    |> Advent.Dijkstra.shortest()
  end

  @doc """
  8 9 1 2 3
  9 1 2 3 4
  1 2 3 4 5
  2 3 4 5 6
  3 4 5 6 7
  """
  def multiply_map(map) do
    map_keys = map |> Map.keys()
    ms = Enum.max(map_keys)

    Enum.reduce(map_keys, %{}, fn c, m ->
      cs = coordinates(c, ms)
      rs = risks(map[c])
      nm = Enum.zip(cs, rs) |> Map.new()
      Map.merge(nm, m)
    end)
  end

  def coordinates({x, y}, {mx, my}) do
    px = mx + 1
    py = my + 1
    tx = px * @times - 1
    ty = py * @times - 1

    for nx <- x..tx//px, ny <- y..ty//py, do: {nx, ny}
  end

  def risks(start) do
    Enum.reduce(1..24, {[start], start}, fn n, {[r | _] = rs, col} ->
      if Integer.mod(n, @times) == 0 do
        ic = inc_risk(col)
        {[ic | rs], ic}
      else
        {[inc_risk(r) | rs], col}
      end
    end)
    |> elem(0)
    |> Enum.reverse()
  end

  defp inc_risk(9), do: 1
  defp inc_risk(r), do: r + 1
end
