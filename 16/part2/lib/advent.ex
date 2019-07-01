defmodule Advent do
  defstruct examples: [], program: []

  alias Advent.Device
  alias Advent.Example

  def file_stream(file) do
    file
    |> File.stream!
    |> Stream.map(&String.trim_trailing/1)
  end

  def read_input(stream) do
    {state, _} = Enum.reduce(stream, {%Advent{}, nil}, &parse/2)
    %Advent{state | program: Enum.reverse(state.program)}
  end

  def parse(line, {%Advent{} = state, example}) do
    cond do
      String.starts_with?(line, "Before: ") ->
        {state, %Example{before: parse_registers(line)}}

      String.starts_with?(line, "After: ") ->
        example = %Example{example | after: parse_registers(line)}
        {%Advent{examples: [ example | state.examples ]}, nil}

      String.length(line) == 0 -> {state, nil}

      is_nil(example) -> 
        attrs = String.split(line) |> Enum.map(&String.to_integer/1)
        {%Advent{state | program: [ attrs | state.program ]}, example}

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

  def map_examples(%Advent{examples: es, program: _}) do
    for e <- es, into: %{}, do: {e, Example.filter_ops(e)}
  end

  def filter_by_singular_example(ex_map) do
    Enum.filter(ex_map, fn {_, ops} -> length(ops) == 1 end)
    |> Enum.map(fn {e, [op]} -> {op, [Example.opcode(e)]} end)
    |> Enum.uniq
    |> Map.new
  end

  def filter_found_ops(op_map) do
    Device.ops() -- Map.keys(op_map)
  end

  def map_possible_opcodes(op_map, ex_map) do
    filter_found_ops(op_map)
    |> Enum.reduce(op_map, fn op, op_map ->
      Map.put(op_map, op,
        Enum.filter(ex_map, fn {_, ops} -> Enum.member?(ops, op) end)
        |> Enum.map(fn {e, _} -> Example.opcode(e) end)
        |> Enum.uniq
      )
    end)
  end

  def map_singular_opcodes_to_funcs(op_map) do
    Enum.filter(op_map, fn {_, ocs} -> length(ocs) == 1 end)
    |> Enum.reduce(%{}, fn {func, [oc]}, m -> Map.put(m, oc, func) end)
  end

  def remove_found_opcodes(op_map, opcode_func) do
    Enum.map(op_map, fn {f, ocs} -> {f, ocs -- Map.keys(opcode_func)} end)
    |> Enum.filter(fn {f, _} -> !Enum.member?(Map.values(opcode_func), f) end)
    |> Map.new
  end

  def reduce_opcodes(opcode_func, op_map) when op_map == %{}, do: opcode_func
  def reduce_opcodes(opcode_func, op_map) do
    op_map = remove_found_opcodes(op_map, opcode_func)

    map_singular_opcodes_to_funcs(op_map)
    |> Map.merge(opcode_func)
    |> reduce_opcodes(op_map)
  end

  def eval(file \\ "input/input.txt") do
    state =
      file_stream(file)
      |> read_input

    ex_map = map_examples(state)

    op_map =
      filter_by_singular_example(ex_map)
      |> map_possible_opcodes(ex_map)

    opcode_func =
      map_singular_opcodes_to_funcs(op_map)
      |> reduce_opcodes(op_map)

    run_program({0,0,0,0}, state.program, opcode_func)
    |> elem(0)
  end

  def run_program(registers, [], _), do: registers
  def run_program(registers, [ [op, a, b, c] | rest ], opcode_func) do
    apply(opcode_func[op], [registers, a, b, c])
    |> run_program(rest, opcode_func)
  end

end
