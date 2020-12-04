defmodule Advent do
  @moduledoc """
  """

  @doc """
  Multiply numbers that sum to 2020.

  ## Examples

    iex> Advent.eval([1721, 979, 366, 299, 675, 1456])
    241861950

  """
  @spec eval(list()) :: integer()
  def eval(entries \\ Advent.Input.parse()) do
    for a <- entries, b <- entries, c <- entries, eq2020?(a, b, c) do
      a * b * c
    end
    |> hd()
  end

  @doc """
  Return `true` if all three given integers sum to 2020.

  ## Examples

    iex> Advent.eq2020?(979, 366, 675)
    true

    iex> Advent.eq2020?(979, 299, 675)
    false

  """
  @spec eq2020?(integer(), integer(), integer()) :: boolean()
  def eq2020?(x, y, z) when x + y + z == 2020, do: true
  def eq2020?(_, _, _), do: false
end
