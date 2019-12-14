defmodule Advent do
  defstruct state: nil, position: 0, input: [1], output: [], relative_base: 0
  @moduledoc false

  def input_file() do
    {:ok, dev} = File.open("../input/input.txt")
    dev
  end

  def read_input(dev \\ input_file()) do
    IO.read(dev, :all)
    |> String.split(",", trim: true)
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(&elem(&1, 0))
  end

  def list_to_map(list) do
    Enum.reduce(list, {Map.new(), 0}, fn n, {map, p} -> {Map.put(map, p, n), p + 1} end)
    |> elem(0)
  end

  def state_to_list(%Advent{state: s}) do
    limit = Map.keys(s) |> Enum.max()
    for i <- 0..limit, do: Map.get(s, i, 0)
  end

  # --- parsing

  def operation(%Advent{state: s, position: p} = state) do
    Map.get(s, p, 0)
    |> Integer.digits()
    |> (fn
          [n] -> [0, n]
          a -> a
        end).()
    |> Enum.reverse()
    |> parse_op_digits(state)
  end

  def parse_op_digits(inst, %Advent{state: s, position: p, relative_base: rb}) do
    case inst do
      [1, 0 | modes] ->
        {
          :add,
          param_for(s, p, modes, rb, 0),
          param_for(s, p, modes, rb, 1),
          write_param_for(s, p, modes, rb, 2)
        }

      [2, 0 | modes] ->
        {
          :multiply,
          param_for(s, p, modes, rb, 0),
          param_for(s, p, modes, rb, 1),
          write_param_for(s, p, modes, rb, 2)
        }

      [3, 0 | modes] ->
        {
          :input,
          write_param_for(s, p, modes, rb, 0)
        }

      [4, 0 | modes] ->
        {
          :output,
          param_for(s, p, modes, rb, 0)
        }

      [5, 0 | modes] ->
        if param_for(s, p, modes, rb, 0) == 0 do
          {:nojump}
        else
          {:jump, param_for(s, p, modes, rb, 1)}
        end

      [6, 0 | modes] ->
        if param_for(s, p, modes, rb, 0) == 0 do
          {:jump, param_for(s, p, modes, rb, 1)}
        else
          {:nojump}
        end

      [7, 0 | modes] ->
        {
          :less,
          param_for(s, p, modes, rb, 0),
          param_for(s, p, modes, rb, 1),
          write_param_for(s, p, modes, rb, 2)
        }

      [8, 0 | modes] ->
        {
          :equal,
          param_for(s, p, modes, rb, 0),
          param_for(s, p, modes, rb, 1),
          write_param_for(s, p, modes, rb, 2)
        }

      [9, 0 | modes] ->
        {
          :adjust,
          param_for(s, p, modes, rb, 0)
        }

      [9, 9] ->
        :halt
    end
  end

  def param_for(state, position, modes, relative_base, offset) do
    param = Map.get(state, position + offset + 1, 0)

    case Enum.at(modes, offset) do
      nil -> Map.get(state, param, 0)
      0 -> Map.get(state, param, 0)
      1 -> param
      2 -> Map.get(state, param + relative_base, 0)
    end
  end

  def write_param_for(state, position, modes, relative_base, offset) do
    param = Map.get(state, position + offset + 1, 0)
    if Enum.at(modes, offset) == 2, do: param + relative_base, else: param
  end

  # --- operations

  def operate(%Advent{state: s, position: p, input: i, output: o, relative_base: rb} = state) do
    operation(state)
    |> case do
      {:add, a, b, dest} ->
        %Advent{state | state: Map.put(s, dest, a + b), position: p + 4}
        |> operate()

      {:multiply, a, b, dest} ->
        %Advent{state | state: Map.put(s, dest, a * b), position: p + 4}
        |> operate()

      {:input, dest} ->
        {input, rest} =
          case i do
            [val | rest] -> {val, rest}
            [] -> raise(":input instruction without value #{inspect(state)}")
          end

        %Advent{state | state: Map.put(s, dest, input), position: p + 2, input: rest}
        |> operate()

      {:output, value} ->
        %Advent{state | output: [value | o], position: p + 2}
        |> operate()

      {:nojump} ->
        %Advent{state | position: p + 3}
        |> operate()

      {:jump, dest} ->
        %Advent{state | position: dest}
        |> operate()

      {:less, a, b, dest} ->
        val = if a < b, do: 1, else: 0

        %Advent{state | state: Map.put(s, dest, val), position: p + 4}
        |> operate()

      {:equal, a, b, dest} ->
        val = if a == b, do: 1, else: 0

        %Advent{state | state: Map.put(s, dest, val), position: p + 4}
        |> operate()

      {:adjust, a} ->
        %Advent{state | relative_base: rb + a, position: p + 2}
        |> operate()

      :halt ->
        %Advent{state | output: Enum.reverse(o)}
    end
  end

  # ---

  def first_output(%Advent{output: o}), do: hd(o)

  def eval() do
    map =
      read_input()
      |> list_to_map()

    %Advent{state: map}
    |> operate()
    |> inspect()
  end
end
