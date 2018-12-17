defmodule Advent do

  def read_input(dev \\ :stdio) do
    IO.read(dev, :all)
    |> String.split("\n", trim: true)
    |> Enum.map(fn l ->
      String.split(l, ",", trim: true)
      |> Enum.map(&String.trim/1)
      |> Enum.map(&String.to_integer/1)
      |> (fn p -> {Enum.at(p, 0), Enum.at(p, 1)} end).()
    end)
  end

  def md({ax, ay}, {bx, by}) do
    abs(bx - ax) + abs(by - ay)
  end

  def max_x(list) do
    Enum.map(list, &elem(&1, 0)) |> Enum.max
  end

  def min_x(list) do
    Enum.map(list, &elem(&1, 0)) |> Enum.min
  end

  def max_y(list) do
    Enum.map(list, &elem(&1, 1)) |> Enum.max
  end

  def min_y(list) do
    Enum.map(list, &elem(&1, 1)) |> Enum.min
  end

  def aggregate_distance(list, c) do
    Enum.reduce(list, 0, fn p, d -> d + md(p, c) end)
  end

  def eval(list \\ read_input(), distance \\ 32) do

    {max_x, min_x, max_y, min_y} = {
      Advent.max_x(list),
      Advent.min_x(list),
      Advent.max_y(list),
      Advent.min_y(list)
    }

    for(y <- (min_y - 1)..(max_y + 1), x <- (min_x - 1)..(max_x + 1), do: {x,y})
    |> Enum.reduce(0, fn p, count ->
      if aggregate_distance(list, p) < distance do
        count + 1
      else
        count
      end
    end)
  end

end
