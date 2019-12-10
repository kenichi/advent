defmodule Advent do
  defstruct state: nil, position: 0, input: 5, output: []
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

  # --- parsing

  def operation(%Advent{state: s, position: p} = state) do
    Enum.at(s, p)
    |> Integer.digits()
    |> (fn
          [n] -> [0, n]
          a -> a
        end).()
    |> Enum.reverse()
    |> parse_op_digits(state)
  end

  def parse_op_digits(inst, %Advent{state: s, position: p}) do
    case inst do
      [1, 0 | modes] ->
        {
          :add,
          param_for(s, p, modes, 0),
          param_for(s, p, modes, 1),
          Enum.at(s, p + 3)
        }

      [2, 0 | modes] ->
        {
          :multiply,
          param_for(s, p, modes, 0),
          param_for(s, p, modes, 1),
          Enum.at(s, p + 3)
        }

      [3 | _] ->
        {:input, Enum.at(s, p + 1)}

      [4, 0 | modes] ->
        {
          :output,
          param_for(s, p, modes, 0)
        }

      [5, 0 | modes] ->
        if param_for(s, p, modes, 0) == 0 do
          {:nojump}
        else
          {:jump, param_for(s, p, modes, 1)}
        end

      [6, 0 | modes] ->
        if param_for(s, p, modes, 0) == 0 do
          {:jump, param_for(s, p, modes, 1)}
        else
          {:nojump}
        end

      [7, 0 | modes] ->
        {
          :less,
          param_for(s, p, modes, 0),
          param_for(s, p, modes, 1),
          Enum.at(s, p + 3)
        }

      [8, 0 | modes] ->
        {
          :equal,
          param_for(s, p, modes, 0),
          param_for(s, p, modes, 1),
          Enum.at(s, p + 3)
        }

      [9, 9] ->
        :halt
    end
  end

  def param_for(state, position, modes, offset) do
    param = Enum.at(state, position + offset + 1)
    if Enum.at(modes, offset) == 1, do: param, else: Enum.at(state, param)
  end

  # --- operations

  def operate(%Advent{state: s, position: p, input: i, output: o} = state) do
    operation(state)
    |> case do
      {:add, a, b, dest} ->
        %Advent{state | state: List.replace_at(s, dest, a + b), position: p + 4}
        |> operate()

      {:multiply, a, b, dest} ->
        %Advent{state | state: List.replace_at(s, dest, a * b), position: p + 4}
        |> operate()

      {:input, dest} ->
        %Advent{state | state: List.replace_at(s, dest, i), position: p + 2}
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

        %Advent{state | state: List.replace_at(s, dest, val), position: p + 4}
        |> operate()

      {:equal, a, b, dest} ->
        val = if a == b, do: 1, else: 0

        %Advent{state | state: List.replace_at(s, dest, val), position: p + 4}
        |> operate()

      :halt ->
        %Advent{state | output: Enum.reverse(o)}
    end
  end

  # ---

  def first_output(%Advent{output: o}) do
    case Enum.reverse(o) do
      [v] -> v
      [v | _] -> v
      [] -> raise("no output")
    end
  end

  def eval() do
    %Advent{state: read_input()}
    |> operate()
    |> first_output()
  end
end
