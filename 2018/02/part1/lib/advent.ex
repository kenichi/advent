defmodule Advent do

  def read_input(dev \\ :stdio) do
    IO.read(dev, :all)
    |> String.split("\n")
    |> Enum.map(&String.trim(&1))
    |> Enum.reject(&(String.length(&1) == 0))
  end

  def checksum(list \\ read_input()) do
    counts = Enum.reduce(list, {0, 0}, fn s, a ->
      m = parse(s)
      dos  = if count(m, 2) > 0, do: 1, else: 0
      tres = if count(m, 3) > 0, do: 1, else: 0
      put_elem(a, 0, elem(a, 0) + dos)
      |> put_elem(1, elem(a, 1) + tres)
    end)
    elem(counts, 0) * elem(counts, 1)
  end

  def count(map, freq) do
    Enum.reduce(map, 0, fn {_, c}, s ->
      if c == freq, do: s + 1, else: s
    end)
  end

  def parse(str) do
    to_charlist(str)
    |> Enum.reduce(%{}, fn c, m -> add_char(m, c) end)
  end

  def add_char(map, char) do
    if Map.has_key? map, char do
      Map.put map, char, map[char] + 1
    else
      Map.put map, char, 1
    end
  end

end
