defmodule Advent do
  @moduledoc false

  @card ~r/Card\s+(\d+):\s+/

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> total_points()
  end

  @doc """
  Find the points of each card and sum.

  1 2 3 4 5 
  1 2 4 8 16
  """
  @spec total_points([String.t()]) :: integer()
  def total_points(list) do
    Enum.reduce(list, 0, fn card, points ->
      [prefix, _id] = Regex.run(@card, card)

      [win, have] =
        card
        |> String.trim_leading(prefix)
        |> String.split("|", trim: true)
        |> Enum.map(&split_to_set/1)

      match =
        win
        |> MapSet.intersection(have)
        |> MapSet.size()

      if match > 0 do
        Integer.pow(2, match - 1) + points
      else
        points
      end
    end)
  end

  defp split_to_set(str) do
    str
    |> String.split(" ", trim: true)
    |> MapSet.new()
  end
end
