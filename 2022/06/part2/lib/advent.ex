defmodule Advent do
  @moduledoc false

  @doc """
  Advent!
  """
  def eval() do
    Advent.Input.parse()
    |> start_of_message_marker()
  end

  def start_of_message_marker(input) do
    Enum.reduce_while(input, {[], 0}, &reduce_until_repeat/2)
  end

  defp reduce_until_repeat(char, {list, index}) when length(list) < 14,
    do: {:cont, {list ++ [char], index + 1}}

  defp reduce_until_repeat(char, {list, index}) do
    if no_repeats?(list) do
      {:halt, index}
    else
      {:cont, {tl(list) ++ [char], index + 1}}
    end
  end

  defp no_repeats?(list) do
    length(list) == length(Enum.uniq(list))
  end
end
