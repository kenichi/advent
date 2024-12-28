defmodule Advent.Input do
  @moduledoc "input reading/parsing"

  @type acc :: {Advent.t(), integer(), integer()}

  @input_file "input.txt"

  def read(), do: File.read!(@input_file)

  @spec parse(String.t()) :: Advent.t()
  def parse(input \\ read()) do
    input
    |> String.trim()
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split("", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.reduce({%Advent{}, 0, 0}, &reduce_line/2)
    |> elem(0)
  end

  @spec reduce_line([String.t()], acc()) :: acc()
  defp reduce_line(line, {advent, x, y}) do
    maxy = Enum.max([advent.maxy, y])

    {advent, _, _} =
      Enum.reduce(line, {advent, x, y}, fn h, {a, x, y} ->
        heads =
          if h == 0 do
            [{x, y} | a.heads]
          else
            a.heads
          end

        map = Map.put(a.map, {x, y}, h)

        maxx = Enum.max([a.maxx, x])

        {%Advent{a | heads: heads, map: map, maxx: maxx}, x + 1, y}
      end)

    {%Advent{advent | maxy: maxy}, 0, y + 1}
  end
end
