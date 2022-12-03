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
    |> Enum.map(&split_and_fetch_item_priority/1)
    |> Enum.sum()
  end

  def split_and_fetch_item_priority(line) do
    line
    |> split_in_half()
    |> find_shared_item()
    |> fetch_priority()
  end

  defp split_in_half(line) do
    at = div(String.length(line), 2)
    String.split_at(line, at)
  end

  defp find_shared_item({a, b}) do
    as = String.codepoints(a) |> MapSet.new()
    bs = String.codepoints(b) |> MapSet.new()

    [item] =
      as
      |> MapSet.intersection(bs)
      |> MapSet.to_list()

    item
  end

  @priority ~w[
    a b c d e f g h i j k l m n o p q r s t u v w x y z
    A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
  ]

  defp fetch_priority(item), do: Enum.find_index(@priority, &(&1 == item)) + 1
end
