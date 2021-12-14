defmodule Advent do
  def eval([map_points | folds] = _input \\ Advent.Input.parse()) do
    set = MapSet.new(map_points)

    # Enum.reduce(folds, set, fn {axis, value}, s ->
    #   mx = Enum.max(s, fn {a, _}, {b, _} -> a > b end) |> elem(0)
    #   my = Enum.max(s, fn {_, a}, {_, b} -> a > b end) |> elem(1)

    #   fold_map(axis, value, {s, mx, my})
    # end)

    mx = Enum.max(set, fn {a, _}, {b, _} -> a > b end) |> elem(0)
    my = Enum.max(set, fn {_, a}, {_, b} -> a > b end) |> elem(1)

    {axis, value} = hd(folds)
    fold_map(axis, value, {set, mx, my})
    |> MapSet.size()
  end

  def fold_map(:x, value, {set, _mx, my}) do
    # left half points
    folded =
      Enum.filter(set, &(elem(&1, 0) < value))
      |> MapSet.new()

    value
    |> transpose_from()
    |> Enum.reduce(folded, fn {ox, nx}, fs ->
      Enum.reduce(0..my, fs, fn y, fs ->
        if MapSet.member?(set, {ox, y}) do
          MapSet.put(fs, {nx, y})
        else
          fs
        end
      end)
    end)
  end

  def fold_map(:y, value, {set, mx, _my}) do
    # top half points
    folded =
      Enum.filter(set, &(elem(&1, 1) < value))
      |> MapSet.new()

    value
    |> transpose_from()
    |> Enum.reduce(folded, fn {oy, ny}, fs ->
      Enum.reduce(0..mx, fs, fn x, fs ->
        if MapSet.member?(set, {x, oy}) do
          MapSet.put(fs, {x, ny})
        else
          fs
        end
      end)
    end)
  end

  def transpose_from(i) do
    Enum.reduce((i + 1)..(i * 2), {[], 1}, fn n, {l, c} ->
      {[{n, i - c} | l], c + 1}
    end)
    |> elem(0)
  end
end
