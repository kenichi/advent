defmodule Advent do
  @moduledoc false

  @doc """
  Return sum of least and greatest numbers in a sequence that sums to the first
  invalid number.
  """
  @spec eval(List.t(), integer()) :: integer()
  def eval(numbers \\ Advent.Input.read(), psize \\ 25) do
    target = first_invalid(numbers, psize)

    slice =
      Enum.reduce_while(initial_slice_range(numbers), nil, fn slize, _ ->
        case reduce_slice_sums(numbers, slize, target) do
          nil -> {:cont, nil}
          slice -> {:halt, slice}
        end
      end)

    Enum.min(slice) + Enum.max(slice)
  end

  @doc """
  ## Examples

    iex> Advent.reduce_slice_sums([6, 5, 3, 6], 3, 14)
    [6, 5, 3]

    iex> Advent.reduce_slice_sums([6, 5, 3, 2], 3, 13)
    nil

  """
  @spec reduce_slice_sums(List.t(), integer(), integer()) :: List.t() | nil
  def reduce_slice_sums(numbers, slice_size, target) do
    index_range = 0..(length(numbers) - slice_size)
    Enum.reduce_while(index_range, nil, fn i, _ ->
      slice_sum_to?(numbers, i, slice_size, target)
    end)
  end

  @doc """
  ## Examples

    iex> Advent.slice_sum_to?([6, 5, 3, 6], 0, 3, 14)
    {:halt, [6, 5, 3]}

    iex> Advent.slice_sum_to?([6, 5, 3, 2], 0, 3, 13)
    {:cont, nil}

  """
  def slice_sum_to?(numbers, i, slice_size, target) do
    slice = Enum.slice(numbers, i, slice_size)
    if Enum.sum(slice) == target do
      {:halt, slice}
    else
      {:cont, nil}
    end
  end

  @doc """
  ## Examples

    iex> Advent.initial_slice_range([6, 5, 3, 6])
    ** (ArgumentError) list length less than five

    iex> Advent.initial_slice_range([6, 5, 3, 2, 4, 5, 10])
    2..5

  """
  def initial_slice_range(numbers) when length(numbers) < 5 do
    raise ArgumentError, "list length less than five"
  end
  def initial_slice_range(numbers), do: 2..(length(numbers) - 2)

  @doc """
  Return first number that is invalid xmas.
  """
  def first_invalid(numbers, psize) do
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
