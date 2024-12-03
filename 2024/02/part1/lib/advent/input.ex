defmodule Advent.Input do
  @moduledoc "input reading/parsing"

  @input_file "input.txt"

  def read(), do: File.read!(@input_file)

  @spec parse(String.t()) :: [[integer()]]
  def parse(input \\ read()) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&map_line/1)
  end

  defp map_line(line) do
    line
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
