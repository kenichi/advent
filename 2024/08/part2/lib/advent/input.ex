defmodule Advent.Input do
  @moduledoc "input reading/parsing"

  @input_file "input.txt"

  def read(), do: File.read!(@input_file)

  @spec parse(String.t()) :: Advent.t()
  def parse(input \\ read()) do
    lines =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(&split_line/1)
      |> Enum.with_index()

    Enum.reduce(lines, %Advent{}, fn {line, y}, a ->
      Enum.reduce(line, a, fn {char, x}, advent ->
        advent
        |> update_maxes(x, y)
        |> update_map(String.to_atom(char), {x, y})
      end)
    end)
  end

  @spec split_line(String.t()) :: [{String.t(), integer()}]
  defp split_line(line) do
    line
    |> String.split("", trim: true)
    |> Enum.with_index()
  end

  @spec update_maxes(Advent.t(), integer(), integer()) :: Advent.t()
  defp update_maxes(advent, x, y) do
    maxx = Enum.max([advent.maxx, x])
    maxy = Enum.max([advent.maxy, y])

    %Advent{advent | maxx: maxx, maxy: maxy}
  end

  @spec update_map(Advent.t(), Advent.frequency(), Advent.coord()) :: Advent.t()
  defp update_map(advent, :., _coord), do: advent

  defp update_map(advent, frequency, coord) do
    coords = Map.get(advent.map, frequency, [])
    new_coords = [coord | coords]

    %Advent{advent | map: Map.put(advent.map, frequency, new_coords)}
  end
end
