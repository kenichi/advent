defmodule Advent.Input do
  @moduledoc "input reading/parsing"

  @input_file "input.txt"

  def read(), do: File.read!(@input_file)

  def parse(input \\ read()),
    do:
      input
      |> String.split("\n\n", trim: true)
      |> Enum.map(&String.split(&1, "\n", trim: true))
end
