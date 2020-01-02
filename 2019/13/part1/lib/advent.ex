alias Advent.Intcode

defmodule Advent do
  @moduledoc false

  def list_to_map(list) do
    Enum.reduce(list, {Map.new(), 0}, fn n, {map, p} -> {Map.put(map, p, n), p + 1} end)
    |> elem(0)
  end

  def state_to_list({:halt, ic}), do: state_to_list(ic)

  def state_to_list(%Advent.Intcode{state: s}) do
    limit = Map.keys(s) |> Enum.max()
    for i <- 0..limit, do: Map.get(s, i, 0)
  end

  # ---

  def intcode_output() do
    Intcode.new()
    |> Intcode.operate()
    |> (fn {:halt, ic} -> Enum.chunk_every(ic.output, 3) end).()
  end

  def eval() do
    intcode_output()
    |> Enum.filter(fn [_, _, i] -> i == 2 end)
    |> length()
    |> inspect()
  end
end
