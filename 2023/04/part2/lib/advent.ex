defmodule Advent do
  @moduledoc false

  @card ~r/Card\s+(\d+):\s+/

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> total_cards()
  end

  @doc """
  Find the points of each card and sum.

  1 2 3 4 5 
  1 2 4 8 16
  """
  @spec total_cards([String.t()]) :: integer()
  def total_cards(list) do
    list
    |> parse_cards()
    |> process_cards()
    |> Map.values()
    |> Enum.sum()
  end

  defp parse_cards(list) do
    Enum.reduce(list, %{}, fn card, map ->
      [prefix, id] = Regex.run(@card, card)
      {id, _} = Integer.parse(id)

      [win, have] =
        card
        |> String.trim_leading(prefix)
        |> String.split("|", trim: true)
        |> Enum.map(&split_to_set/1)

      match =
        win
        |> MapSet.intersection(have)
        |> MapSet.size()

      Map.put(map, id, match)
    end)
  end

  defp split_to_set(str) do
    str
    |> String.split(" ", trim: true)
    |> MapSet.new()
  end

  defp process_cards(cards) do
    total = Enum.reduce(cards, %{}, fn {id, _}, m -> Map.put(m, id, 1) end)
    max = Map.keys(cards) |> Enum.max()

    Enum.reduce(1..max, total, fn id, total ->
      match = cards[id]
      if match > 0 do
        winnings = Range.to_list((id + 1)..(id + match))

        Enum.reduce(1..total[id], total, fn _, total ->
          Enum.reduce(winnings, total, fn id, t ->
            Map.update(t, id, 1, fn n -> n + 1 end)
          end)
        end)
      else
        total
      end
    end)
  end
end
