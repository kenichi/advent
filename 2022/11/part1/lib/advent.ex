defmodule Advent do
  @moduledoc false

  alias Advent.{Input, Monkey}

  @doc """
  Advent!
  """
  def eval() do
    Input.parse()
    |> monkey_business()
  end

  def monkey_business(input) do
    input
    |> initial_state()
    |> do_twenty_rounds()
    |> Map.values()
    |> Enum.map(& &1.inspections)
    |> Enum.sort(:desc)
    |> Enum.slice(0, 2)
    |> then(&apply(Kernel, :*, &1))
  end

  defp initial_state(input) do
    input
    |> Enum.map(&Monkey.parse_monkey/1)
    |> Enum.into(%{}, fn m -> {m.id, m} end)
  end

  defp do_twenty_rounds(state, count \\ 20)

  defp do_twenty_rounds(state, 0), do: state

  defp do_twenty_rounds(state, count) do
    state
    |> do_round()
    |> do_twenty_rounds(count - 1)
  end

  defp do_round(state) do
    state
    |> Map.keys()
    |> Enum.sort()
    |> Enum.reduce(state, &reduce_round/2)
  end

  defp reduce_round(monkey_id, state) do
    state
    |> Map.get(monkey_id)
    |> Monkey.inspect_items()
    |> throw_items(state)
  end

  defp throw_items({monkey, throws}, state) do
    Enum.reduce(throws, state, fn {item, to}, state ->
      rec = state[to]

      state
      |> Map.put(to, %Monkey{rec | items: rec.items ++ [item]})
      |> Map.put(monkey.id, %Monkey{monkey | items: []})
    end)
  end
end
