defmodule Advent do
  @moduledoc false

  def input_file() do
    {:ok, dev} = File.open("../input/input.txt")
    dev
  end

  def read_input(dev \\ input_file()) do
    IO.read(dev, :all)
    |> String.split("\n", trim: true)
    |> Enum.map(fn l -> String.split(l, ",", trim: true) end)
  end

  def plot(dir, {set, cursor}) do
    add_step(set, cursor, parse_dir(dir))
  end

  def add_step(set, cursor, {_, 0}), do: {set, cursor}

  def add_step(set, {x, y}, {d, n}) do
    step =
      case d do
        :U -> {x, y + 1}
        :D -> {x, y - 1}
        :R -> {x + 1, y}
        :L -> {x - 1, y}
      end

    MapSet.put(set, step) |> add_step(step, {d, n - 1})
  end

  def parse_dir(dir) do
    {d, n} = String.split_at(dir, 1)
    {String.to_atom(d), Integer.parse(n) |> elem(0)}
  end

  def eval([a, b] \\ read_input()) do
    path_a =
      Enum.reduce(a, {MapSet.new(), {0, 0}}, &plot/2)
      |> elem(0)

    path_b =
      Enum.reduce(b, {MapSet.new(), {0, 0}}, &plot/2)
      |> elem(0)

    MapSet.intersection(path_a, path_b)
    |> Enum.sort(fn {ax, ay}, {bx, by} ->
      abs(ax) + abs(ay) < abs(bx) + abs(by)
    end)
    |> hd
    |> (fn {x, y} -> abs(x) + abs(y) end).()
  end
end
