defmodule Advent do
  @moduledoc false

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> signal_strengths()
    |> Enum.sum()
  end

  @cycles [20, 60, 100, 140, 180, 220]

  def signal_strengths(input) do
    {_cycle, _x, signals} = Enum.reduce(input, {0, 1, []}, &reduce_instructions/2)
    Enum.reverse(signals)
  end

  defp reduce_instructions(inst, state) do
    state
    |> cycle(inst)
    |> perform(inst)
  end

  defp cycle(state, "addx" <> _) do
    state
    |> next_cycle()
    |> next_cycle()
  end

  defp cycle(state, _), do: next_cycle(state)

  defp next_cycle({cycle, x, signals}) do
    cycle = cycle + 1
    signals = if cycle in @cycles, do: [x * cycle | signals], else: signals
    {cycle, x, signals}
  end

  defp perform({cycle, x, signals}, "addx " <> n), do: {cycle, x + String.to_integer(n), signals}

  defp perform(state, "noop"), do: state
end
