defmodule Advent do

  @spec eval(List.t()) :: Integer.t()
  def eval(fish \\ Advent.Input.parse(), days \\ 256) do
    1..days 
    |> Enum.reduce(fish, fn _day, fs ->
      fs
      |> day()
      |> Advent.spawn()
    end)
    |> Map.values()
    |> Enum.sum()
  end

  def spawn(%{-1 => c} = fs) do
    fs
    |> Map.put(6, Map.get(fs, 6, 0) + c)
    |> Map.put(8, c)
    |> Map.delete(-1)
  end

  def day(fs) do
    Enum.reduce(fs, %{}, fn {f, c}, m -> Map.put(m, f - 1, c) end)
  end
end
