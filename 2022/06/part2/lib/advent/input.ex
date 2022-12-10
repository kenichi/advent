defmodule Advent.Input do
  @moduledoc "input reading/parsing"

  @input_file "input.txt"

  def read(), do: File.read!(@input_file)
  def parse(input \\ read()), do: String.codepoints(input)
end
