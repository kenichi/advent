defmodule Advent do
  @moduledoc false

  @doc """
  Return count of bags that one shiny gold bag can eventually contain.
  """
  @spec eval(List.t()) :: integer()
  def eval(rules \\ Advent.Input.parse()) do
    count_bags(rules, :shiny_gold)
  end

  defp count_bags(rules, color, count \\ 0) do
    case Map.get(rules, color) do
      nil ->
        count

      contents ->
        Enum.reduce(contents, count, fn {contained, qty}, n ->
          n + qty + count_bags(rules, contained) * qty
        end)
    end
  end
end
