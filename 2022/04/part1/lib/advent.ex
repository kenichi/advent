defmodule Advent do
  @moduledoc false

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> count_containments()
  end

  def count_containments(list) do
    list
    |> Enum.filter(&containment?/1)
    |> length()
  end

  defp containment?(line) do
    line
    |> parse_line()
    |> contained?()
  end

  defp parse_line(line) do
    line
    |> String.split(",")
    |> Enum.map(&split_to_int/1)
  end

  defp split_to_int(ranges) do
    ranges
    |> String.split("-")
    |> Enum.map(&String.to_integer/1)
  end

  defp contained?([[as, ae], [bs, be]]) do
    (bs >= as && bs <= ae && (be >= as && be <= ae)) or
      (as >= bs && as <= be && (ae >= bs && ae <= be))
  end
end
