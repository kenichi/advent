defmodule Advent do

  def build_grid(serial, max \\ 300) do
    for x <- 1..max do
      for y <- 1..max, do: cell_power(x, y, serial)
    end
  end

  def cell_power(x, y, serial) do
    rack_id = x + 10

    (((rack_id * y) + serial) * rack_id)
    |> Integer.digits
    |> Enum.at(-3)
    |> (fn pl -> pl - 5 end).()
  end

  def square_power(grid, x, y) do
    x = x - 1
    y = y - 1

    for x <- x..(x + 2) do
      for y <- y..(y + 2) do
        Enum.at(grid, x) |> Enum.at(y)
      end
      |> Enum.sum
    end
    |> Enum.sum
  end

  def max_square(grid, max \\ 300) do
    for x <- 1..(max - 2) do
      for y <- 1..(max - 2) do
        {x, y}
      end
    end
    |> List.flatten
    |> Enum.max_by(fn {x, y} -> square_power(grid, x, y) end)
  end

  def eval(serial \\ 7400) do
    serial
    |> build_grid
    |> max_square
  end

end
