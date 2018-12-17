require Logger

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

  def eval(list \\ read_input()) do

    {max_x, min_x, max_y, min_y} = {
      Advent.max_x(list),
      Advent.min_x(list),
      Advent.max_y(list),
      Advent.min_y(list)
    }

    grid = for y <- (min_y - 1)..(max_y + 1) do
      for x <- (min_x - 1)..(max_x + 1) do
        closest_index list, {x,y}
      end
    end

    edgeset =
      Enum.at(grid, 0) ++
      Enum.at(grid, ((max_y + 1) - (min_y - 1))) ++
      Enum.map(grid, &(Enum.at(&1, 0))) ++
      Enum.map(grid, &(Enum.at(&1, ((max_x + 1) - (min_x - 1)))))
      |> Enum.reduce(MapSet.new(), fn c, set ->
        case c do
          {:equal, i} ->
            Logger.error("found {:equal, #{i}} at edge")
            set

          {:single, i} -> MapSet.put(set, i)
          {:multi, nil} -> set

          _ ->
            Logger.error("unexpected value at edge")
            set
        end
      end)

    finite_indices =
      Enum.to_list(0..(length(list) - 1))
      |> Enum.reject(&MapSet.member?(edgeset, &1))
      |> Enum.reduce(%{}, &Map.put(&2, &1, 0))

    Enum.reduce(grid, finite_indices, fn row, fi ->
      Enum.reduce(row, fi, fn {atom, index}, fi ->
        if atom == :single || atom == :equal do
          if Map.has_key?(fi, index) do
            Map.put(fi, index, fi[index] + 1)
          else
            fi
          end
        else
          fi
        end
      end)
    end)
    |> Enum.sort(fn {_,a}, {_,b} -> a > b end)
    |> hd
    |> elem(1)
  end

  def closest_index(list, c) do
    if i = Enum.find_index(list, &(&1 == c)) do
      {:equal, i}
    else
      result = Enum.reduce(list, {-1,0,-1}, fn p, {cl, idx, d} ->
        distance = md(p, c)

        cond do
          (cl == -1 && d == -1) -> {idx, idx + 1, distance}
          distance < d -> {idx, idx + 1, distance}
          (cl == nil || distance == d) -> {nil, idx + 1, d}
          true -> {cl, idx + 1, d}
        end
      end)

      case result do
        {nil, _, _} -> {:multi, nil}
        {cl, _, _} -> {:single, cl}
      end
    end
  end

end
