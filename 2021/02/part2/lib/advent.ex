defmodule Advent do
  @moduledoc """
  What do you get if you multiply your final horizontal position by your final depth?
  """

  @doc """
  ## Examples

    iex> Advent.eval([{:f, 5}, {:d, 5}, {:f, 8}, {:u, 3}, {:d, 8}, {:f, 2}])
    900

  """
  @spec eval(List.t()) :: Integer.t()
  def eval(instructions \\ Advent.Input.parse()) do
    instructions
    |> Enum.reduce({0, 0, 0}, fn
      {:f, n}, {h, d, a} -> {h + n, d + (a * n), a}
      {:u, n}, {h, d, a} -> {h, d, a - n}
      {:d, n}, {h, d, a} -> {h, d, a + n}
    end)
    |> then(fn {h, d, _} -> h * d end)
  end
end
