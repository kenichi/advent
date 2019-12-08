defmodule Advent do
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

  def eval() do
    read_input()
    |> List.replace_at(1, 12)
    |> List.replace_at(2, 2)
    |> operate()
    |> Enum.at(0)
  end
end
