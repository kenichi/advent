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
    Enum.reduce(1..n, stacks, fn _, s -> move_crate(s, f, t) end)
  end

  defp move_crate(stacks, from, to) do
    from_stack = Map.get(stacks, from)
    to_stack = Map.get(stacks, to)

    stacks
    |> Map.put(from, tl(from_stack))
    |> Map.put(to, [hd(from_stack) | to_stack])
  end

  defp top_crates(stacks) do
    stacks
    |> Map.keys()
    |> Enum.sort()
    |> Enum.map(fn i -> hd(stacks[i]) end)
  end
end
