defmodule Advent.Input do
  @moduledoc "input reading/parsing"

  @input_file "input.txt"

  def read(), do: File.read!(@input_file)

  @spec parse(String.t()) :: [{integer(), [integer()]}]
  def parse(input \\ read()) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_calibration/1)
  end

  @spec parse_calibration(String.t()) :: {integer(), [integer()]}
  defp parse_calibration(line) do
    [value, numbers] = String.split(line, ":")

    numbers =
      numbers
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)

    {String.to_integer(value), numbers}
  end
end
