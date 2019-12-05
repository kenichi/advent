defmodule Guard do
  defstruct id: -1, schedules: []

  def total_sleeps(g) do
    Enum.reduce(g.schedules, 0, fn r, t -> t + length(Enum.to_list(r)) end)
  end

  def most_slept(g) do
    most_frequent(g)
    |> elem(0)
  end

  def most_frequent(g) do
    Enum.reduce(g.schedules, %{}, fn range, map ->
      Enum.reduce(range, map, fn min, map ->
        Map.update(map, min, 1, fn n -> n + 1 end)
      end)
    end)
    |> Enum.sort(fn {_,a}, {_,b} -> a > b end)
    |> hd()
    |> Tuple.append(g)
  end

end
