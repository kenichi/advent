defmodule Advent do
  @total 1_000_000_000

  def parse(file) do
    File.stream!(file)
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, y}, map ->
      String.codepoints(line)
      |> Enum.map(&String.to_atom/1)
      |> Enum.with_index()
      |> Enum.reduce(map, fn {a, x}, map ->
        Map.put(map, {x, y}, a)
      end)
    end)
  end

  def print(map) do
    {{minx, maxx}, {miny, maxy}} =
      {Map.keys(map) |> Enum.map(fn {x, _} -> x end) |> Enum.min_max(),
       Map.keys(map) |> Enum.map(fn {_, y} -> y end) |> Enum.min_max()}

    Enum.reduce(miny..maxy, nil, fn y, _ ->
      Enum.reduce(minx..maxx, nil, fn x, _ ->
        IO.write(map[{x, y}])
        nil
      end)

      IO.write("\n")
      nil
    end)
  end

  def neighbors(map, {x, y}) do
    [
      {x - 1, y - 1},
      {x, y - 1},
      {x + 1, y - 1},
      {x - 1, y},
      {x + 1, y},
      {x - 1, y + 1},
      {x, y + 1},
      {x + 1, y + 1}
    ]
    |> Enum.map(fn p -> map[p] end)
    |> Enum.filter(fn a -> !is_nil(a) end)
  end

  def transition(:., map, p) do
    l = neighbors(map, p)
    if Enum.count(l, fn a -> a == :| end) >= 3, do: :|, else: :.
  end

  def transition(:|, map, p) do
    l = neighbors(map, p)
    if Enum.count(l, fn a -> a == :"#" end) >= 3, do: :"#", else: :|
  end

  def transition(:"#", map, p) do
    l = neighbors(map, p)
    ls = Enum.count(l, fn a -> a == :"#" end)
    ts = Enum.count(l, fn a -> a == :| end)
    if ls > 0 && ts > 0, do: :"#", else: :.
  end

  def minute(map) do
    Enum.map(map, fn {p, a} -> {p, transition(a, map, p)} end)
    |> Map.new()
  end

  def minutes(map, 0), do: map
  def minutes(map, n), do: minutes(minute(map), n - 1)

  def repeat(map, count \\ @total) do
    Enum.reduce_while(1..count, {map, %{map => 0}}, fn i, {m, seen} ->
      nm = minute(m)
      if Map.has_key?(seen, nm) do
        {:halt, {nm, i}}
      else
        {:cont, {nm, Map.put(seen, nm, i)}}
      end
    end)
  end

  def eval(file \\ "input/input.txt") do
    {map, first} =
      parse(file)
      |> repeat

    {map, cycle} = repeat(map)

    minutes(map, rem(@total - first, cycle))
    |> Map.values()
    |> (fn vs ->
          Enum.count(vs, fn v -> v == :| end) *
            Enum.count(vs, fn v -> v == :"#" end)
        end).()
  end
end
