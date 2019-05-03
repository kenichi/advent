defmodule Advent do

  def build_grid(serial, max \\ 300) do
    for x <- 1..max, y <- 1..max, into: %{}, do: {{x, y}, cell_power(x, y, serial)}
  end

  def cell_power(x, y, serial) do
    rack_id = x + 10

    (((rack_id * y) + serial) * rack_id)
    |> Integer.digits
    |> Enum.at(-3)
    |> (fn pl -> pl - 5 end).()
  end

  def build_summed_area_table(grid) do
    Map.keys(grid)
    |> Enum.sort
    |> Enum.reduce(%{}, fn {x, y}, sat ->
      Map.put(sat, {x, y}, summed_area(grid, sat, x, y))
    end)
  end

  def summed_area(grid, _sat, 1, 1) do
    grid[{1, 1}]
  end

  def summed_area(grid, sat, 1, y) do
    grid[{1, y}] + sat[{1, y - 1}]
  end

  def summed_area(grid, sat, x, 1) do
    grid[{x, 1}] + sat[{x - 1, 1}]
  end

  def summed_area(grid, sat, x, y) do
    grid[{x, y}] +
    sat[{x, y - 1}] +
    sat[{x - 1, y}] -
    sat[{x - 1, y - 1}]
  end

  def square_power(sat, x, y, size \\ 3) do
    delta = size - 1

    sat[{x + delta, y + delta}] +
    Map.get(sat, {x - 1, y - 1}, 0) -
    Map.get(sat, {x + delta, y - 1}, 0) -
    Map.get(sat, {x - 1, y + delta}, 0)
  end

  def find_largest(sat) do
    for x <- 1..300, y <- 1..300 do
      for s <- 1..(301 - max(x, y)) do
        {{x, y, s}, square_power(sat, x, y, s)}
      end
      |> Enum.max_by(fn {_, p} -> p end)
    end
    |> Enum.max_by(fn {_, p} -> p end)
  end

  def eval(serial \\ 7400) do
    serial
    |> build_grid
    |> build_summed_area_table
    |> find_largest
  end

end
