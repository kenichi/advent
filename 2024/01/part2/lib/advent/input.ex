defmodule Advent.Input do
  @moduledoc "input reading/parsing"

  @input_file "input.txt"

  def read(), do: File.read!(@input_file)

  @spec parse(String.t()) :: {[integer()], [integer()]}
  def parse(input \\ read()) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce({[], []}, &reduce_line/2)
  end

  defp reduce_line(line, {left, right}) do
    [l, r] =
      line
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)

    {[l | left], [r | right]}
  end
end
