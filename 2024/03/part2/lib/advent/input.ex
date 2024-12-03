defmodule Advent.Input do
  @moduledoc "input reading/parsing"

  @input_file "input.txt"

  def read(), do: File.read!(@input_file)

  @spec parse(String.t()) :: String.t()
  def parse(input \\ read()) do
    input
    |> String.split("\n", trim: true)
    |> Enum.join("")
  end
end
