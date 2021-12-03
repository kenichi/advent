defmodule Advent do
  @moduledoc """
  """

  @doc """
  How many sums are larger than the previous sum?

  ## Examples

    iex> Advent.eval([199, 200, 208, 210, 200, 207, 240, 269, 260, 263])
    5

  """
  @spec eval(List.t()) :: Integer.t()
  def eval(measurements \\ Advent.Input.parse()) do
    measurements
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.map(&Enum.sum/1)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.reduce(0, fn [a, b], i -> if(b > a, do: i + 1, else: i) end)
  end
end
