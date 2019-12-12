defmodule Advent do
  defstruct state: nil, position: 0, input: [], output: []
  @moduledoc false
  @ps [0, 1, 2, 3, 4]

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
        {input, rest} =
          case i do
            [val | rest] -> {val, rest}
            [] -> raise(":input instruction without value #{inspect(state)}")
          end

        %Advent{state | state: List.replace_at(s, dest, input), position: p + 2, input: rest}
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

  def first_output(%Advent{output: o}), do: hd(o)

  def combos() do
    for(a <- @ps, b <- @ps, c <- @ps, d <- @ps, e <- @ps, do: [a, b, c, d, e])
    |> Enum.filter(&(Enum.uniq(&1) |> length() == 5))
  end

  def amplify([a, b, c, d, e]) do
    template = %Advent{state: read_input()}

    ampA =
      %Advent{template | input: [a, 0]}
      |> operate()
      |> first_output

    ampB =
      %Advent{template | input: [b, ampA]}
      |> operate()
      |> first_output

    ampC =
      %Advent{template | input: [c, ampB]}
      |> operate()
      |> first_output

    ampD =
      %Advent{template | input: [d, ampC]}
      |> operate()
      |> first_output

    %Advent{template | input: [e, ampD]}
    |> operate()
    |> first_output
  end

  def eval() do
    combos()
    |> Enum.map(fn combo -> {amplify(combo), combo} end)
    |> Enum.max_by(&elem(&1, 0))
    |> inspect()
  end
end
