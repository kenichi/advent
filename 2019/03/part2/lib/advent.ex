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

  def add_step(set, {x, y, s, map}, {d, n}) do
    count = s + 1

    {sx, sy} =
      case d do
        :U -> {x, y + 1}
        :D -> {x, y - 1}
        :R -> {x + 1, y}
        :L -> {x - 1, y}
      end

    map = Map.put_new(map, {sx, sy}, count)
    MapSet.put(set, {sx, sy}) |> add_step({sx, sy, count, map}, {d, n - 1})
  end

  def parse_dir(dir) do
    {d, n} = String.split_at(dir, 1)
    {String.to_atom(d), Integer.parse(n) |> elem(0)}
  end

  # def intersections(a, b) do
  #   Enum.reduce(a, MapSet.new(), fn {ax, ay, as}, set ->
  #     Enum.reduce(b, set, fn {bx, by, bs}, set ->
  #       if ax == bx && ay == by do
  #         MapSet.put(set, {ax, ay, as + bs})
  #       else
  #         set
  #       end
  #     end)
  #   end)
  # end

  def eval([a, b] \\ read_input()) do
    {path_a, {_, _, _, map_a}} = Enum.reduce(a, {MapSet.new(), {0, 0, 0, %{}}}, &plot/2)

    {path_b, {_, _, _, map_b}} = Enum.reduce(b, {MapSet.new(), {0, 0, 0, %{}}}, &plot/2)

    MapSet.intersection(path_a, path_b)
    |> Enum.map(fn {x, y} = xy -> {x, y, map_a[xy] + map_b[xy]} end)
    |> Enum.sort(fn {_, _, a}, {_, _, b} -> a < b end)
    |> hd()
    |> elem(2)
  end
end
