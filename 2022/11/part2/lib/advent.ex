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
    |> do_rounds(10_000)
    |> elem(0)
    |> Map.values()
    |> Enum.map(& &1.inspections)
    |> Enum.sort(:desc)
    |> Enum.slice(0, 2)
    |> then(&apply(Kernel, :*, &1))
  end

  defp initial_state(input) do
    monkeys = Enum.map(input, &Monkey.parse_monkey/1)
    map = Enum.into(monkeys, %{}, fn m -> {m.id, m} end)
    lcm = Enum.map(monkeys, & &1.test) |> Enum.product()

    {map, lcm}
  end

  defp do_rounds(state, 0), do: state

  defp do_rounds(state, count) do
    state
    |> do_round()
    |> do_rounds(count - 1)
  end

  defp do_round({map, _lcm} = state) do
    map
    |> Map.keys()
    |> Enum.sort()
    |> Enum.reduce(state, &reduce_round/2)
  end

  defp reduce_round(monkey_id, {map, lcm} = state) do
    map
    |> Map.get(monkey_id)
    |> Monkey.inspect_items(lcm)
    |> throw_items(state)
  end

  defp throw_items({monkey, throws}, state) do
    Enum.reduce(throws, state, fn {item, to}, {map, lcm} ->
      rec = map[to]

      map =
        map
        |> Map.put(to, %Monkey{rec | items: rec.items ++ [item]})
        |> Map.put(monkey.id, %Monkey{monkey | items: []})

      {map, lcm}
    end)
  end
end
