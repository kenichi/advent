defmodule Advent do
  @moduledoc false

  @size_limit 100_000

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> small_directories_sizes()
    |> Enum.sum()
  end

  def small_directories_sizes(tree), do: Enum.reduce(tree, [], &reduce_dirs/2)

  defp reduce_dirs({_key, val}, dirs) when is_map(val) do
    ds = dir_size(val)

    dirs =
      if ds <= @size_limit do
        [ds | dirs]
      else
        dirs
      end

    dirs ++ small_directories_sizes(val)
  end

  defp reduce_dirs({_key, _val}, dirs), do: dirs

  defp dir_size(tree, start \\ 0), do: Enum.reduce(tree, start, &reduce_tree/2)

  defp reduce_tree({_key, val}, sum) when is_map(val), do: dir_size(val, sum)

  defp reduce_tree({_key, val}, sum) when is_integer(val), do: sum + val
end
