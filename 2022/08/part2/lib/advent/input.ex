defmodule Advent.Input do
  @moduledoc "input reading/parsing"

  @input_file "input.txt"

  def read(), do: File.read!(@input_file)

  def parse(input \\ read()) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce({%{}, 0}, &reduce_line/2)
    |> elem(0)
  end

  defp reduce_line(line, {map, y}) do
    heights =
      line
      |> String.codepoints()
      |> Enum.map(&String.to_integer/1)

    row_map =
      for(x <- 0..length(heights), do: {x, y})
      |> Enum.zip(heights)
      |> Map.new()

    {Map.merge(map, row_map), y + 1}
  end
end
