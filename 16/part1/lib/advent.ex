defmodule Advent do
  defstruct examples: []

  alias Advent.Device
  alias Advent.Example

  def file_stream(file) do
    file
    |> File.stream!
    |> Stream.map(&String.trim_trailing/1)
  end

  def read_input(stream) do
    {state, _} = Enum.reduce(stream, {%Advent{}, nil}, &parse/2)
    state
  end

  def parse(line, {state, example}) do
    cond do
      String.starts_with?(line, "Before: ") ->
        {state, %Example{before: parse_registers(line)}}

      String.starts_with?(line, "After: ") ->
        example = %Example{example | after: parse_registers(line)}
        {%Advent{examples: [ example | state.examples ]}, nil}

      String.length(line) == 0 -> {state, nil}
      is_nil(example) -> {state, nil}

      # example is not nil, i.e. between before and after
      # line length is not 0, meaning this is an op line
      true ->
        attrs = String.split(line) |> Enum.map(&String.to_integer/1)
        {state, %Example{example | attrs: attrs}}
    end
  end

  def parse_registers(line) do
    line
    |> String.slice(9, 10)
    |> String.split(", ")
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple
  end

  def eval(file \\ "input/input.txt") do
    state =
      file_stream(file)
      |> read_input

    state.examples
    |> Enum.filter(fn e ->
      valid = Example.filter_ops(e) |> length
      valid >= 3
    end)
    |> length
  end
end
