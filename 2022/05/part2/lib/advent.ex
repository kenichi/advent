defmodule Advent do
  @moduledoc false

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> stack_supplies()
  end

  def stack_supplies({stacks, steps}) do
    steps
    |> Enum.reduce(stacks, &reduce_step/2)
    |> top_crates()
    |> Enum.join("")
  end

  defp reduce_step({n, f, t}, stacks) do
    fs = Map.get(stacks, f)
    ts = Map.get(stacks, t)

    new_from_stack = Enum.slice(fs, n, length(fs))
    new_to_stack = Enum.slice(fs, 0, n) ++ ts

    stacks
    |> Map.put(f, new_from_stack)
    |> Map.put(t, new_to_stack)
  end

  defp top_crates(stacks) do
    stacks
    |> Map.keys()
    |> Enum.sort()
    |> Enum.map(fn i -> hd(stacks[i]) end)
  end
end
