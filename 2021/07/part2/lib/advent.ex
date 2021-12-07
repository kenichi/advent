defmodule Advent do

  @spec eval(List.t()) :: Integer.t()
  def eval(positions \\ Advent.Input.parse()) do
    positions
    |> Enum.min_max()
    |> then(fn {mn, mx} -> Range.new(mn, mx) end)
    |> Enum.reduce([], fn p, l -> [fuel_for(p, positions) | l] end)
    |> Enum.min()
  end

  def fuel_for(dest, positions) do
    positions
    |> Enum.map(& sum_range(&1, dest))
    |> Enum.sum()
  end

  def sum_range(p, dest) do
    d = abs(p - dest)
    div((d + 1) * d, 2)
  end
end
