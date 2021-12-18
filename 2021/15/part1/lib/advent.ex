defmodule Advent do
  def eval(map \\ Advent.Input.parse()) do
    map
    |> Advent.Dijkstra.shortest()
    |> Enum.map(&map[&1])
    |> Enum.sum()
  end
end
