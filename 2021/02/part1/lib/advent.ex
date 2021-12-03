defmodule Advent do
  @moduledoc """
  What do you get if you multiply your final horizontal position by your final depth?
  """

  @doc """
  ## Examples

    iex> Advent.eval([{:f, 5}, {:d, 5}, {:f, 8}, {:u, 3}, {:d, 8}, {:f, 2}])
    150

  """
  @spec eval(List.t()) :: Integer.t()
  def eval(instructions \\ Advent.Input.parse()) do
    instructions
    |> Enum.reduce({0, 0}, fn
      {:f, n}, {h, d} -> {h + n, d}
      {:u, n}, {h, d} -> {h, d - n}
      {:d, n}, {h, d} -> {h, d + n}
    end)
    |> then(fn {h, d} -> h * d end)
  end
end
