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
      Enum.reduce(line, a, fn {char, x}, a ->
        %Advent{
          a
          | map: Map.put(a.map, {x, y}, char),
            maxx: Enum.max([a.maxx, x]),
            maxy: Enum.max([a.maxy, y])
        }
      end)
    end)
  end

  @spec split_line(String.t()) :: [{String.t(), integer()}]
  defp split_line(line) do
    line
    |> String.split("", trim: true)
    |> Enum.with_index()
  end
end