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
    |> Enum.map(fn p -> abs(p - dest) end)
    |> Enum.sum()
  end
end
