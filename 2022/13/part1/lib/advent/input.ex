defmodule Advent.Input do
  @moduledoc "input reading/parsing"

  @input_file "input.txt"

  def read(), do: File.read!(@input_file)

  def parse(input \\ read()) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.map(&map_input/1)
  end

  defp map_input(pairs) do
    pairs
    |> String.split("\n", trim: true)
    |> Enum.map(fn s ->
      s
      |> Code.eval_string()
      |> elem(0)
    end)
  end
end
