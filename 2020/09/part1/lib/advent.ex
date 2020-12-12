defmodule Advent do
  @moduledoc false

  @doc """
  Return first number that is invalid xmas.
  """
  @spec eval(List.t(), integer()) :: integer()
  def eval(numbers \\ Advent.Input.read(), psize \\ 25) do
    preamble = Enum.slice(numbers, 0, psize)
    range = psize..(length(numbers) - 1)
    rest = Enum.slice(numbers, range)
    Enum.reduce_while(rest, preamble, fn n, p ->
      if sum_of_preambles?(p, n) do
        {:cont, rotate(p, n)}
      else
        {:halt, n}
      end
    end)
  end

  @doc """
  ## Examples

    iex> Advent.sum_of_preambles?([1, 2, 3], 1)
    false

    iex> Advent.sum_of_preambles?([1, 2, 3], 3)
    true

    iex> Advent.sum_of_preambles?([1, 2, 3], 4)
    true

    iex> Advent.sum_of_preambles?([1, 2, 3], 5)
    true

    iex> Advent.sum_of_preambles?([1, 2, 3], 6)
    false

  """
  @spec sum_of_preambles?(List.t(), integer()) :: boolean()
  def sum_of_preambles?(preamble, n) do
    Enum.any?(preamble, fn p -> (n - p) in drop_first(preamble, p) end)
  end

  @doc """
  ## Examples

    iex> Advent.rotate([1, 2, 3], 4)
    [2, 3, 4]

  """
  @spec rotate(List.t(), any()) :: List.t()
  def rotate([_ | suffix], n), do: suffix ++ [n]

  @doc """
  ## Examples

    iex> Advent.drop_first([1, 2, 3, 2], 2)
    [1, 3, 2]

    iex> Advent.drop_first([1, 2, 3, 2], 4)
    [1, 2, 3, 2]

  """
  @spec drop_first(List.t(), any()) :: List.t()
  def drop_first(_, x, new \\ [])
  def drop_first([h | t], x, new) when h == x, do: new ++ t
  def drop_first([h | t], x, new), do: drop_first(t, x, [h | new])
  def drop_first([], _, new), do: Enum.reverse(new)
end
