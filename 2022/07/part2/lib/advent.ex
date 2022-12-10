defmodule Advent do
  @moduledoc false

  @max 70_000_000
  @req 30_000_000

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> smallest_directory_to_delete()
  end

  def smallest_directory_to_delete(tree) do
    used = dir_size(tree)
    free = @max - used
    need = @req - free

    tree
    |> dir_sizes()
    |> Enum.filter(&(&1 >= need))
    |> Enum.sort()
    |> hd()
  end

  defp dir_sizes(tree, sizes \\ []),
    do: Enum.reduce(tree, sizes, &reduce_size/2)

  defp reduce_size({_key, val}, sizes) when is_map(val) do
    sizes = [dir_size(val) | sizes]

    dir_sizes(val, sizes)
  end

  defp reduce_size({_key, val}, sizes) when is_integer(val), do: sizes

  defp dir_size(tree, start \\ 0), do: Enum.reduce(tree, start, &reduce_tree/2)

  defp reduce_tree({_key, val}, sum) when is_map(val), do: dir_size(val, sum)

  defp reduce_tree({_key, val}, sum) when is_integer(val), do: sum + val
end
