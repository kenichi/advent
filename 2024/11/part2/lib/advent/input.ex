defmodule Advent.Input do
  @moduledoc "input reading/parsing"

  @input_file "input.txt"

  def read(), do: File.read!(@input_file)

  @spec parse(String.t()) :: Advent.freqs()
  def parse(input \\ read()) do
    input
    |> String.trim()
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.frequencies()
  end
end
