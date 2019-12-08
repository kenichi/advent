defmodule Advent do
  @moduledoc false
  @target 19690720

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

  def operate(state, position \\ 0) do
    Enum.slice(state, position..(position + 3))
    |> handle_operand(state, position)
  end

  def handle_operand([1, a, b, dest], state, position) do
    sum = Enum.at(state, a) + Enum.at(state, b)
    operate(List.replace_at(state, dest, sum), position + 4)
  end

  def handle_operand([2, a, b, dest], state, position) do
    prod = Enum.at(state, a) * Enum.at(state, b)
    operate(List.replace_at(state, dest, prod), position + 4)
  end

  def handle_operand([99, _, _, _], state, _), do: state
  def handle_operand([99, _, _], state, _), do: state
  def handle_operand([99, _], state, _), do: state
  def handle_operand([99], state, _), do: state

  def run(state, noun \\ 12, verb \\ 2) do
    state
    |> List.replace_at(1, noun)
    |> List.replace_at(2, verb)
    |> operate()
    |> Enum.at(0)
  end

  def find_noun([_|_] = state), do: find_noun({state, 0})
  def find_noun({state, noun}) do
    if run(state, noun, 0) >= @target do
      {state, noun - 1}
    else
      find_noun({state, noun + 1})
    end
  end

  def find_verb({state, noun}), do: find_verb({state, noun, 0})
  def find_verb({state, noun, verb}) do
    r = run(state, noun, verb)
    cond do
      r == @target -> {noun, verb}
      r < @target -> find_verb({state, noun, verb + 1})
      r > @target -> raise("oops")
    end
  end

  def eval() do
    read_input()
    |> find_noun()
    |> find_verb()
    |> (fn {n, v} -> 100 * n + v end).()
  end
end
