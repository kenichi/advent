defmodule Advent do
  @moduledoc """
  """

  @doc """
  Multiply numbers that sum to 2020.

  ## Examples

    iex> Advent.eval([1721, 979, 366, 299, 675, 1456])
    514579

  """
  @spec eval(List.t()) :: Integer.t()
  def eval(entries \\ Advent.Input.parse()) do
    Enum.reduce_while(entries, {nil, nil}, fn a, pairs ->
      Enum.reduce_while(entries, pairs, fn b, pairs ->
        if a + b == 2020, do: {:halt, {a, b}}, else: {:cont, pairs}
      end)
      |> case do
        {nil, nil} -> {:cont, pairs}
        _ = found -> {:halt, found}
      end
    end)
    |> (fn {a, b} -> a * b end).()
  end
end
