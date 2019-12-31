defmodule Advent.Intcode do
  defstruct state: nil, position: 0, input: [0], output: [], relative_base: 0

  def first_output(%__MODULE__{output: o}), do: hd(o)

  def input(value, %__MODULE__{input: i} = ic), do: %__MODULE__{ic | input: [value | i]}

  def new(list \\ Advent.Input.read()) do
    %__MODULE__{state: Advent.list_to_map(list)}
  end

  # --- parsing

  def operation(%__MODULE__{state: s, position: p} = state) do
    Map.get(s, p, 0)
    |> Integer.digits()
    |> (fn
          [n] -> [0, n]
          a -> a
        end).()
    |> Enum.reverse()
    |> parse_op_digits(state)
  end

  def parse_op_digits(inst, %__MODULE__{state: s, position: p, relative_base: rb}) do
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

  def operate(%__MODULE__{state: s, position: p, input: i, output: o, relative_base: rb} = state) do
    operation(state)
    |> case do
      {:add, a, b, dest} ->
        %__MODULE__{state | state: Map.put(s, dest, a + b), position: p + 4}
        |> operate()

      {:multiply, a, b, dest} ->
        %__MODULE__{state | state: Map.put(s, dest, a * b), position: p + 4}
        |> operate()

      {:input, dest} ->
        case i do
          [input | rest] ->
            %__MODULE__{state | state: Map.put(s, dest, input), position: p + 2, input: rest}
            |> operate()

          [] ->
            {:input, state}
        end

      {:output, value} ->
        %__MODULE__{state | output: [value | o], position: p + 2}
        |> operate()

      {:nojump} ->
        %__MODULE__{state | position: p + 3}
        |> operate()

      {:jump, dest} ->
        %__MODULE__{state | position: dest}
        |> operate()

      {:less, a, b, dest} ->
        val = if a < b, do: 1, else: 0

        %__MODULE__{state | state: Map.put(s, dest, val), position: p + 4}
        |> operate()

      {:equal, a, b, dest} ->
        val = if a == b, do: 1, else: 0

        %__MODULE__{state | state: Map.put(s, dest, val), position: p + 4}
        |> operate()

      {:adjust, a} ->
        %__MODULE__{state | relative_base: rb + a, position: p + 2}
        |> operate()

      :halt ->
        {:halt, %__MODULE__{state | output: Enum.reverse(o)}}
    end
  end
end
