defmodule Advent do
  @moduledoc false

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> calculate_priority_sum()
  end

  def calculate_priority_sum(list) do
    list
    |> Enum.chunk_every(3)
    |> Enum.map(&find_badge_item_priority/1)
    |> Enum.sum()
  end

  defp find_badge_item_priority(group) do
    group
    |> find_shared_item()
    |> fetch_priority()
  end

  defp find_shared_item([a, b, c]) do
    as = String.codepoints(a) |> MapSet.new()
    bs = String.codepoints(b) |> MapSet.new()
    cs = String.codepoints(c) |> MapSet.new()

    [item] =
      as
      |> MapSet.intersection(bs)
      |> MapSet.intersection(cs)
      |> MapSet.to_list()

    item
  end

  @priority ~w[
    a b c d e f g h i j k l m n o p q r s t u v w x y z
    A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
  ]

  defp fetch_priority(item), do: Enum.find_index(@priority, &(&1 == item)) + 1
end
