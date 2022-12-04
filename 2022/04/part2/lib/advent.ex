defmodule Advent do
  @moduledoc false

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> count_overlaps()
  end

  def count_overlaps(list), do: Enum.count(list, &overlaps?/1)

  defp overlaps?(line) do
    line
    |> parse_line()
    |> then(&(not apply(Range, :disjoint?, &1)))
  end

  defp parse_line(line) do
    [[as, ae], [bs, be]] =
      line
      |> String.split(",")
      |> Enum.map(&split_to_int/1)

    [as..ae, bs..be]
  end

  defp split_to_int(ranges) do
    ranges
    |> String.split("-")
    |> Enum.map(&String.to_integer/1)
  end
end
