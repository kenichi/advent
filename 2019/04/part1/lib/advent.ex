defmodule Advent do
  @moduledoc false

  def six_digits?(n), do: n > 99999 && n < 1_000_000

  def in_range?(n), do: n >= 231_832 && n <= 767_346

  def adjacent_digits?(n) do
    Integer.digits(n)
    |> Enum.chunk_every(2, 1)
    |> Enum.any?(fn
      [a, b] -> a == b
      [_] -> false
    end)
  end

  def never_decreases?(n) do
    Integer.digits(n)
    |> Enum.chunk_every(2, 1)
    |> Enum.all?(fn
      [a, b] -> a <= b
      [_] -> true
    end)
  end

  def valid?(n) do
    six_digits?(n) &&
      in_range?(n) &&
      adjacent_digits?(n) &&
      never_decreases?(n)
  end

  def eval() do
    Enum.reduce(231_832..767_346, 0, fn n, count ->
      if valid?(n), do: count + 1, else: count
    end)
  end
end
